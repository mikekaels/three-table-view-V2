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

protocol CategoryViewDelegate: AnyObject {
    func categoryTapped(value: String)
}

class CategoryViewController: ViewController {
    
    private typealias CategoryListSectionModel = AnimatableSectionModel<String, TreeNode>
    weak var delegate: CategoryViewDelegate?
    
    public func inject(viewModel: CategoryViewModel,
                       categoryView: CategoryView,
                       delegate: CategoryViewDelegate) {
        self.viewModel = viewModel
        self.categoryView = categoryView
        self.delegate = delegate
    }

    override func viewDidLoad() {
        self.configureDataSource()
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.title = "Categories"
        viewModel?.loadCategories()
    }
    
    override func loadView() {
        super.loadView()
        self.categoryView?.navigationController = self.navigationController
        self.categoryView?.frame = view.frame
        self.view = categoryView
    }
    
    internal var viewModel: CategoryViewModel!
    private var categoryView: CategoryView?
    
    private var dataSource: RxTableViewSectionedAnimatedDataSource<CategoryListSectionModel>!
    
    private func configureDataSource() {
        dataSource = RxTableViewSectionedAnimatedDataSource<CategoryListSectionModel>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .none,
                                                           reloadAnimation: .automatic,
                                                           deleteAnimation: .none),
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
            
            .drive(onNext: { [weak self] _ in
                guard let `self` = self else { return }
                self.categoryView?.searchController.searchBar.endEditing(true)
            })
            .disposed(by: disposeBag)
        
        viewModel.textSearchDidChange(selection: categoryView.searchController.searchBar.rx.text.asDriver())
            .drive()
            .disposed(by: disposeBag)
        
        viewModel.showLoading.asDriver()
            .map({ value in
                if value == true {
                    self.view.showBlurLoader()
                } else {
                    self.view.removeBluerLoader()
                }
            })
            .drive()
            .disposed(by: disposeBag)
    }
}

//MARK: - DATA SOURCE CONFIGURATION

extension CategoryViewController {
    // Bind Cell to ViewModel
    private var configureCell: RxTableViewSectionedAnimatedDataSource<CategoryListSectionModel>.ConfigureCell {
        return { _, tableView, indexPath, item in
            if item.tree < 3 {
                var cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as! CategoryTableViewCell
                
                cell.bind(to: CategoryCellViewModel(name: item.name, children: item.subNodes.count, level: item.level, highlited: item.highlited, parentId: item.parentId))
                
                return cell
            } else {
                var cell = tableView.dequeueReusableCell(withIdentifier: CategoryLvlThreeViewCell.identifier, for: indexPath) as! CategoryLvlThreeViewCell
                cell.bind(to: CategoryLvlThreeViewModel(categories: self.viewModel.categoriesLvThree))
                cell.delegate = self
                return cell
            }
        }
    }
}

extension CategoryViewController: CategoryLvlThreeViewCellDelegate {
    func didTappedCategory(value: String) {
        self.delegate?.categoryTapped(value: value)
        self.dismiss(animated: true, completion: nil)
    }
}
