//
//  HomeCoordinator.swift
//  TokopediaMiniProject
//
//  Created by Santo Michael Sihombing on 10/04/22.
//

import Foundation
import UIKit
import Core

protocol HomeCoordinator: Coordinator {
    func toCategory()
}

class HomeCoordinatorImplement: HomeCoordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = HomeViewController()
        let view = HomeView()
        let viewModel = HomeViewModelPresentation(coordinator: self)
        
        vc.inject(viewModel: viewModel, homeView: view)
        vc.modalPresentationStyle = .fullScreen
        self.navigationController.setViewControllers([vc], animated: false)
    }
    
    func toCategory() {
        let coordinator = CategoryCoordinatorImplement(navigationController: navigationController)
        
        coordinator.start()
    }
}

