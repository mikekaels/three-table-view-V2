//
//  HomeViewController.swift
//  TokopediaMiniProject
//
//  Created by Santo Michael Sihombing on 10/04/22.
//

import UIKit
import RxSwift
import RxDataSources
import CommonUI
import Core


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
        self.navigationItem.title = "Home"
        self.viewModel?.getCategory()
    }
    
    override func bindViewModel() {
        guard let homeView = self.homeView,
              let viewModel = self.viewModel else {
                  return
              }
        
        homeView.btnSelect.rx.tap.bind { [weak self] _ in
            guard let `self` = self else { return }
            viewModel.goToCategory(delegate: self)
        }
        .disposed(by: disposeBag)

        viewModel.selectedCategory
            .map({ text in
                homeView.lblYouHaveNoSelected.text = text.count > 0 ? "You have choosen" : "You have no selected category"
                return text
            })
            .drive(homeView.lblSelected.rx.text)
            .disposed(by: disposeBag)
    }
    
}

extension HomeViewController: HomeViewDelegate, CategoryViewDelegate {
    func categoryTapped(value: String) {
        viewModel?.saveCategory(value)
    }
}

extension HomeViewController: HomeViewControllerDelegate {
    
}

protocol HomeViewControllerDelegate: AnyObject {
    
}
