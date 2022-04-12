//
//  CategoryCoordinator.swift
//  TokopediaMiniProject
//
//  Created by Santo Michael Sihombing on 12/04/22.
//

import Foundation
import UIKit
import Core

protocol CategoryCoordinator: Coordinator {
    
}

class CategoryCoordinatorImplement: CategoryCoordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = CategoryViewController()
        let view = CategoryView()
        let repository = CategoryDataRepository()
        let useCase = HomeViewDomainUseCase(repository: repository)
        let viewModel = CategoryViewModelPresentation(HomeUseCase: useCase, coordinator: self)
        
        vc.inject(viewModel: viewModel, categoryView: view)
        vc.modalPresentationStyle = .fullScreen
        self.navigationController.setViewControllers([vc], animated: false)
    }
}
