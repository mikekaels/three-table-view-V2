//
//  HomeViewModel.swift
//  TokopediaMiniProject
//
//  Created by Santo Michael Sihombing on 10/04/22.
//

import Core
import RxSwift
import RxCocoa

protocol HomeViewModelInput {
    func didSelectCategory(selection: Driver<IndexPath>, tableView: UITableView, delegate: HomeViewControllerDelegate) -> Driver<Items>
    func getCategories() -> [CategoryItem]
    func loadDisplayArray()
    func addChildrenArray(_ childrenArray: [TreeViewNode])
}

protocol HomeViewModelOutput {
    var categories: Driver<[SectionModel]> { get }
}

protocol HomeViewModel: HomeViewModelInput, HomeViewModelOutput {}


class HomeViewModelPresentation: HomeViewModel {
    
    var categories: Driver<[SectionModel]> {
        return _categories.asDriver()
    }
    
    private let coordinator: HomeCoordinator

    private var _categories = BehaviorRelay<[SectionModel]>(value: [])
    
    private let disposeBag = DisposeBag()
    
    private var displayArray = [Items]()
    private var indentation: Int = 0
    private var nodes: [Items] = []
    private var data: [CategoryItem1] = []
    
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    
        data = TreeViewLists.loadInitialData()
        nodes = TreeViewLists.loadInitialNodes(data)

        self.loadDisplayArray()
    }
    
    func loadDisplayArray() {
        self.displayArray.removeAll()
        for node: TreeViewNode in nodes {
            self.displayArray.append(node)
            
            if (node.isExpanded == true) {
                self.addChildrenArray(node.nodeChildren!)
            }
        }
        
        self._categories.accept([SectionModel(header: "Categories", items: self.displayArray)])
    }
    
    func addChildrenArray(_ childrenArray: [Items]) {
        for node: TreeViewNode in childrenArray {
            self.displayArray.append(node)
            
            if (node.isExpanded == true ) {
                if (node.nodeChildren != nil) {
                    
                    self.addChildrenArray(node.nodeChildren!)
                }
            }
        }
    }
    
    func didSelectCategory(selection: Driver<IndexPath>, tableView: UITableView,  delegate: HomeViewControllerDelegate) -> Driver<Items> {
        return selection.withLatestFrom(categories) { indexPath, categories in
            if let cell = tableView.cellForRow(at: indexPath) as? CategoryViewCell {
                cell.expand()
                cell.setNeedsDisplay()
                self.loadDisplayArray()
            }

            return categories[0].items[indexPath.row]
        }.do(onNext: {category in

        })
    }
    
    func getCategories() -> [CategoryItem] {
        return []
    }
    
}
