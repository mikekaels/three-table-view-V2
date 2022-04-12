//
//  CategoryViewModel.swift
//  TokopediaMiniProject
//
//  Created by Santo Michael Sihombing on 12/04/22.
//

import Foundation
import Core
import RxSwift
import RxCocoa

protocol CategoryViewModelInput {
    func loadCategories()
    func didSelectCategory(selection: Driver<IndexPath>, tableView: UITableView) -> Driver<Item>
    func textSearchDidChange(selection: Driver<String?>) -> Driver<String?>
}

protocol CategoryViewModelOutput {
    var categories: Driver<[DataModel]> { get }
    var textSearch: Driver<String?> { get }
}

protocol CategoryViewModel: CategoryViewModelInput, CategoryViewModelOutput {}


class CategoryViewModelPresentation: CategoryViewModel {
    
    var categories: Driver<[DataModel]> {
        return _categories.asDriver()
    }
    
    var textSearch: Driver<String?> {
        return _textSearch.asDriver()
    }
    
    private let useCase: HomeViewUseCase
    private let disposeBag = DisposeBag()
    
    private let coordinator: CategoryCoordinator
    
    private var _categories = BehaviorRelay<[DataModel]>(value: [])
    private var displayArray = [Item]()
    private var nodes: [Item] = []
    private var _textSearch = BehaviorRelay<String?>(value: "Hello")
    
    init(HomeUseCase: HomeViewUseCase,
         coordinator: CategoryCoordinator) {
        self.useCase = HomeUseCase
        self.coordinator = coordinator
    }
    
    func loadCategories() {
        self.useCase.getCategories()
            .subscribe(onNext: { [weak self] data in
                guard let `self` = self else { return }
                self.nodes = data
                self._categories.accept([DataModel(header: "Categories", items: data)])
            }).disposed(by: disposeBag)
    }
    
    func didSelectCategory(selection: Driver<IndexPath>, tableView: UITableView) -> Driver<Item> {
        return selection.withLatestFrom(categories) { [weak self] indexPath, categories in
            
            guard let `self` = self else { return self!.displayArray[indexPath.row]}
            
            if let _ = tableView.cellForRow(at: indexPath) as? CategoryTableViewCell {
                
                let node = self.nodes[indexPath.row]
                if node.isLeaf {
                    return self.nodes[indexPath.row]
                }
                node.isOpen = !node.isOpen
                
                let subNodes = node.needsDisplayNodes
                
                let insertIndex = self.nodes.firstIndex(of: node)! + 1
                
                if node.isOpen {
                    self.nodes.insert(contentsOf: subNodes, at: insertIndex)
                    
                } else {
                    for subNode in subNodes {
                        guard let index = self.nodes.firstIndex(of: subNode) else {
                            continue
                        }
                        self.nodes.remove(at: index)
                        
                    }
                }
            }
            
            self._categories.accept([DataModel(header: "Categories", items: self.nodes)])
            
            return categories[0].items[indexPath.row]
        }.do(onNext: { category in
            //            print(category)
        })
            }
    
    func textSearchDidChange(selection: Driver<String?>) -> Driver<String?> {
        return selection.withLatestFrom(textSearch) { text, _ in
            guard let text = text else {
                return ""
            }
            print(text)
            return ""
        }.do(onNext: {category in

        })
    }
}
