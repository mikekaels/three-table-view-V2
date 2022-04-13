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
    
    private let useCase: HomeViewUseCase
    private let coordinator: CategoryCoordinator
    
    private var _categories = BehaviorRelay<[TreeNode]>(value: [])
    
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
            
            return node
        }
    }
}


protocol CategoryViewModelInput {
    func loadCategories()
    func didSelectCategory(selection: SharedSequence<DriverSharingStrategy, TreeNode>, tableView: UITableView) -> Driver<TreeNode>
}

protocol CategoryViewModelOutput {
    var categories: Driver<[TreeNode]> { get }
}

protocol CategoryViewModel:  CategoryViewModelInput, CategoryViewModelOutput {}
