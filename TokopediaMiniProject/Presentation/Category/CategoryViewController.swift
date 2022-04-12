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
        
        viewModel?.loadCategories()
    }
    
    internal var viewModel: CategoryViewModel!
    private var categoryView: CategoryView?
    var dataSource: RxTableViewSectionedReloadDataSource<DataModel>!
    
    private func configureDataSource() {
        dataSource = RxTableViewSectionedReloadDataSource<DataModel>(
//            animationConfiguration: AnimationConfiguration(insertAnimation: .left,
//                                                           reloadAnimation: .none,
//                                                           deleteAnimation: .left),
            configureCell: configureCell
        )
    }
    
    override func bindViewModel() {
        
        guard let categoryView = self.categoryView,
              let viewModel = self.viewModel else {
                  return
              }
        
        configureDataSource()
        
        viewModel.categories.asDriver()
            .drive(categoryView.tableview.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        viewModel.didSelectCategory(selection: categoryView.tableview.rx.itemSelected.asDriver(),
                                    tableView: categoryView.tableview)
            .drive()
            .disposed(by: disposeBag)
    }
}

//MARK: - DATA SOURCE CONFIGURATION

extension CategoryViewController {
    private var configureCell: RxTableViewSectionedReloadDataSource<DataModel>.ConfigureCell {
        return { _, tableView, indexPath, item in
            var cell: CategoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as! CategoryTableViewCell
            
            cell.bind(to: CategoryCellViewModel(name: item.name, children: item.subNodes.count, level: item.level))
            
            return cell
        }
    }
}
