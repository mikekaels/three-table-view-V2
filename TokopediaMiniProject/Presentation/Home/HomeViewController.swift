//
//  HomeViewController.swift
//  TokopediaMiniProject
//
//  Created by Santo Michael Sihombing on 10/04/22.
//

import UIKit
import RxSwift
import CommonUI
import Core

protocol HomeViewControllerDelegate: AnyObject {
    
}


class HomeViewController: ViewController {
    private var viewModel : HomeViewModel?
    private var homeView: HomeView?
    
    public func inject(viewModel: HomeViewModel,
                       homeView: HomeView) {
        self.homeView = homeView
        self.viewModel = viewModel
    }
    
    override func loadView() {
        super.loadView()
        self.homeView?.navigationController = self.navigationController
        self.homeView?.frame = view.frame
        self.homeView?.delegate = self
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.title = ""
    }
    
    override func bindViewModel() {
        guard let homeView = self.homeView,
              let viewModel = self.viewModel else {
                  return
              }
        
        viewModel.categories.drive(homeView.tableview
                                    .rx
                                    .items(cellIdentifier: CategoryViewCell.identifier,
                                           cellType: CategoryViewCell.self)) { row, element, cell in
            
            cell.configureCell(node: element)
            
        }.disposed(by: disposeBag)
        
        viewModel.didSelectCategory(selection: homeView.tableview.rx.itemSelected.asDriver(),
                                    tableView: homeView.tableview,
                                    delegate: self)
            .drive()
            .disposed(by: disposeBag)
    }
    
}

extension HomeViewController: HomeViewDelegate {
    
}

extension HomeViewController: HomeViewControllerDelegate {
    
}
