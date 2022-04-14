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
    
    var categoriesLvThree: [TreeNode] {
        return _categoriesLvThree.value
    }
    
    var textSearch: Driver<String> {
        return _textSearch.asDriver()
    }
    
    private let useCase: HomeViewUseCase
    private let coordinator: CategoryCoordinator
    
    private var _categories = BehaviorRelay<[TreeNode]>(value: [])
    private var _categoriesLvThree = BehaviorRelay<[TreeNode]>(value: [])
    private var _textSearch = BehaviorRelay<String>(value: "")
    
    
    let showLoading = BehaviorRelay<Bool>(value: false)
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
        self.showLoading.accept(true)
        self.useCase.getCategories()
            .subscribe(onNext: { [weak self] data in
                guard let `self` = self else { return }
                
                self._categories.accept(data)
                self.tempCategories = data
                self.showLoading.accept(false)
            })
            .disposed(by: disposeBag)
    }
    
    func didSelectCategory(selection: SharedSequence<DriverSharingStrategy, TreeNode>,
                           tableView: UITableView) -> Driver<TreeNode> {
       
        return selection.withLatestFrom(categories) { [weak self] selectedItem, allItems in
            
            guard let `self` = self else { return TreeNode() }

            var categories = allItems
            
            let node = selectedItem
            
            if node.isLeaf { return node }
            
            node.isOpen = !node.isOpen
            
            let subNodes = node.needsDisplayNodes
            
            let insertIndex = categories.firstIndex(of: node)! + 1
            
            if node.tree == 2 {
                if node.isOpen && self.onSearch == true {
                    
                    categories = categories.filter { $0.parentId != node.index }
                    categories.insert(contentsOf: [TreeNode()], at: insertIndex)
                    self._categoriesLvThree.accept(subNodes)
                    
                } else if node.isOpen && self.onSearch == false {
                    
                    categories = categories.filter { $0.parentId != node.index }
                    categories.insert(contentsOf: [TreeNode()], at: insertIndex)
                    self._categoriesLvThree.accept(subNodes)
                    
                } else {
                    
                    categories.remove(at: insertIndex)
                    self._categoriesLvThree.accept([])
                    
                }
            } else {
                
                if node.isOpen && self.onSearch == true {
                    
                    categories = categories.filter { $0.parentId != node.index }
                    categories.insert(contentsOf: subNodes, at: insertIndex)
                    
                } else if node.isOpen && self.onSearch == false {
                    categories.insert(contentsOf: subNodes, at: insertIndex)
                    
                } else {
                    
                    for subNode in subNodes {
                        guard let index = categories.firstIndex(of: subNode) else { continue }
                        categories.remove(at: index)
                    }
                    
                }
            }
            
            self._categories.accept(categories)
            return node
        }
    }
    
    func textSearchDidChange(selection: Driver<String?>) -> Driver<String?> {
        
        return selection
            .debounce(.milliseconds(300))
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
                
                self._categories.accept(result.0.isEmpty ? text.count > 0 ? result.0 : items : result.0)
                self._categoriesLvThree.accept(result.1)
            })
        }
    
    func search(_ items: [TreeNode], _ text: String) -> ([TreeNode],[TreeNode]) {
        if text.isEmpty { return ([],[])}
        
        var categories = [TreeNode]()
        var categoriesLvThree = [TreeNode]()
        
        items.forEach { item in
            item.highlited = text
            if item.tree != 3 {
                if item.name.lowercased().contains("\(text.lowercased())") {
                    if !item.isLeaf {
                        categories.append(item)
                        let found = search(item.needsDisplayNodes, text)
                        categories.append(contentsOf: found.0)
                    } else {
                        categories.append(item)
                    }
                } else {
                    if !item.isLeaf {
                        let found = search(item.needsDisplayNodes, text)
                        if found.0.count != 0 {
                            categories.append(item)
                            categories.append(contentsOf: found.0)
                        }
                    }
                }
            } else {
                categoriesLvThree.append(item)
            }
        }
        
        return (categories, categoriesLvThree)
    }
}


protocol CategoryViewModelInput {
    func loadCategories()
    func textSearchDidChange(selection: Driver<String?>) -> Driver<String?>
    func didSelectCategory(selection: SharedSequence<DriverSharingStrategy, TreeNode>, tableView: UITableView) -> Driver<TreeNode>
}

protocol CategoryViewModelOutput {
    var categories: Driver<[TreeNode]> { get }
    var categoriesLvThree: [TreeNode] { get }
    var textSearch: Driver<String> { get }
    var showLoading: BehaviorRelay<Bool> { get }
}

protocol CategoryViewModel:  CategoryViewModelInput, CategoryViewModelOutput {}
