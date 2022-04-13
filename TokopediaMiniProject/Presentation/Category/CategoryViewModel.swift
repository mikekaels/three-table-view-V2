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
    var _textSearch = BehaviorRelay<String>(value: "")
    private var tempCategories = [TreeNode]()
    private var onSearch = false
    
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
            
            if node.isOpen && self.onSearch == true {
                items = items.filter { $0.parentId != node.index }
                items.insert(contentsOf: subNodes, at: insertIndex)
            } else if node.isOpen && self.onSearch == false {
                items.insert(contentsOf: subNodes, at: insertIndex)
            } else {
                for subNode in subNodes {
                    guard let index = items.firstIndex(of: subNode) else { continue }
                    items.remove(at: index)
                }
            }
            
            self._categories.accept(items)
            return node
        }
    }
    
    func textSearchDidChange(selection: Driver<String?>) -> Driver<String?> {
        return selection
            .debounce(.milliseconds(2000))
            .withLatestFrom(textSearch) { text, _  in
                self.onSearch = true
                return text
            }.do(onNext: { [weak self] text in
                guard let `self` = self else { return }
                
                let items = self.tempCategories
                
                guard let text = text, text.count != 0 else {
                    self.onSearch = false
                    self._categories.accept(items)
                    return
                }
                
                let result = self.search(items, text)
                    
                self._categories.accept(result.isEmpty ? text.count > 0 ? result : items : result)
            })
        }
    
    func search(_ items: [TreeNode], _ text: String) -> [TreeNode] {
        if text.isEmpty { return []}
        
        var result = [TreeNode]()
        
        items.forEach { item in
            item.highlited = text
            if item.name.lowercased().contains("\(text.lowercased())") {
                if !item.isLeaf {
                    result.append(item)
                    let found = search(item.needsDisplayNodes, text)
                    result.append(contentsOf: found)
                } else {
                    result.append(item)
                }
            } else {
                if !item.isLeaf {
                    let found = search(item.needsDisplayNodes, text)
                    if found.count != 0 {
                        result.append(item)
                        result.append(contentsOf: found)
                    }
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
    var _textSearch: BehaviorRelay<String> { get }
}

protocol CategoryViewModel:  CategoryViewModelInput, CategoryViewModelOutput {}
