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
        let viewModel = CategoryViewModelPresentation(useCase: HomeViewDomainUseCase(repository: CategoryDataRepository()),
                                                      coordinator: self)
        
        vc.inject(viewModel: viewModel, categoryView: view)
        self.navigationController.pushViewController(vc, animated: true)
//        self.navigationController.present(vc, animated: true, completion: nil)
    }
}
