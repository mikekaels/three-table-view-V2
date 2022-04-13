//
//  CategoryViewController.swift
//  TokopediaMiniProject
//
//  Created by Santo Michael Sihombing on 12/04/22.
//

import UIKit
import RxSwift
import RxDataSources
import CommonUI
import Core

class CategoryViewController: ViewController {
    
    typealias CategoryListSectionModel = AnimatableSectionModel<String, TreeNode>
    
    public func inject(viewModel: CategoryViewModel,
                       categoryView: CategoryView) {
        self.viewModel = viewModel
        self.categoryView = categoryView
    }
    
    override func loadView() {
        super.loadView()
        self.categoryView?.navigationController = self.navigationController
        self.categoryView?.frame = view.frame
        self.view = categoryView
    }
    
    override func viewDidLoad() {
        self.configureDataSource()
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.title = "Categories"
        self.navigationItem.searchController = categoryView?.searchController
        
        viewModel?.loadCategories()
    }
    
    internal var viewModel: CategoryViewModel!
    private var categoryView: CategoryView?
    
    var dataSource: RxTableViewSectionedAnimatedDataSource<CategoryListSectionModel>!
    
    private func configureDataSource() {
        dataSource = RxTableViewSectionedAnimatedDataSource<CategoryListSectionModel>(
//            animationConfiguration: AnimationConfiguration(insertAnimation: .top,
//                                                           reloadAnimation: .automatic,
//                                                           deleteAnimation: .bottom),
            configureCell: configureCell
        )
    }
    
    override func bindViewModel() {
        
        guard let categoryView = self.categoryView,
              let viewModel = self.viewModel else {
                  return
              }
        
        configureDataSource()
        
        // Bind Data
        viewModel.categories.asDriver()
            .map { [CategoryListSectionModel(model: "", items: $0)]}
            .drive(categoryView.tableview.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        // Bind DidSelectedCell
        viewModel.didSelectCategory(selection: categoryView.tableview.rx.modelSelected(TreeNode.self).asDriver(),
                                    tableView: categoryView.tableview)
            
            .drive()
            .disposed(by: disposeBag)
        
        viewModel.textSearchDidChange(selection: categoryView.searchController.searchBar.searchTextField.rx.text.asDriver())
            .drive()
            .disposed(by: disposeBag)
    }
}

//MARK: - DATA SOURCE CONFIGURATION

extension CategoryViewController {
    // Bind Cell to ViewModel
    private var configureCell: RxTableViewSectionedAnimatedDataSource<CategoryListSectionModel>.ConfigureCell {
        return { _, tableView, indexPath, item in
            var cell: CategoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as! CategoryTableViewCell
            
            cell.bind(to: CategoryCellViewModel(name: item.name, children: item.subNodes.count, level: item.level))
            
            return cell
        }
    }
}
