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

class CategoryViewModelPresentation: DisposableViewModel, CategoryViewModel {
    
    var categories: Driver<[TreeNode]> {
        return _categories.asDriver()
    }
    
    var textSearch: Driver<String> {
        return _textSearch.asDriver()
    }
    
    private let useCase: HomeViewUseCase
    private let coordinator: CategoryCoordinator
    
    private var _categories = BehaviorRelay<[TreeNode]>(value: [])
    private var _textSearch = BehaviorRelay<String>(value: "")
    private var tempCategories = [TreeNode]()
    
    init(useCase: HomeViewUseCase,
         coordinator: CategoryCoordinator) {
        self.useCase = useCase
        self.coordinator = coordinator
    }
}

extension CategoryViewModelPresentation {
    
    func loadCategories() {
        self.useCase.getCategories()
            .subscribe(onNext: { [weak self] data in
                guard let `self` = self else { return }
                self._categories.accept(data)
                self.tempCategories = data
            }).disposed(by: disposeBag)
    }
    
    func didSelectCategory(selection: SharedSequence<DriverSharingStrategy, TreeNode>,
                           tableView: UITableView) -> Driver<TreeNode> {
        
        return selection.withLatestFrom(categories) { [weak self] selectedItem, allItems in
            
            guard let `self` = self else { return TreeNode() }
            
            var items = allItems
            
            let node = selectedItem
            
            if node.isLeaf { return node }
            
            node.isOpen = !node.isOpen
            
            let subNodes = node.needsDisplayNodes
            
            let insertIndex = items.firstIndex(of: node)! + 1
            
            if node.isOpen { items.insert(contentsOf: subNodes, at: insertIndex) }
            
            else {
                for subNode in subNodes {
                    guard let index = items.firstIndex(of: subNode) else { continue }
                    items.remove(at: index)
                }
            }
            
            self._categories.accept(items)
            self.tempCategories = items
            
            return node
        }
    }
    
    func textSearchDidChange(selection: Driver<String?>) -> Driver<String?> {
            return selection.withLatestFrom(textSearch) {[weak self] text, _ in
                guard let `self` = self else { return "" }
                guard let text = text else {
                    return ""
                }
                
                let items = self.tempCategories
                let result = self.search(items, text)
                    
                self._categories.accept(result.isEmpty ? items : result)
                
                return text
            }.do(onNext: {category in

            })
        }
    
    func search(_ items: [TreeNode], _ text: String) -> [TreeNode] {
        if text.isEmpty { return []}
        
        var result = [TreeNode]()
        
        items.forEach {
            if $0.name.contains(text) {
                result.append($0)
                if !$0.isLeaf {
                    let found = search($0.needsDisplayNodes, text)
                    result.append(contentsOf: found)
                }
            }
        }
        
        return result
    }
}


protocol CategoryViewModelInput {
    func loadCategories()
    func textSearchDidChange(selection: Driver<String?>) -> Driver<String?>
    func didSelectCategory(selection: SharedSequence<DriverSharingStrategy, TreeNode>, tableView: UITableView) -> Driver<TreeNode>
}

protocol CategoryViewModelOutput {
    var categories: Driver<[TreeNode]> { get }
    var textSearch: Driver<String> { get }
}

protocol CategoryViewModel:  CategoryViewModelInput, CategoryViewModelOutput {}
