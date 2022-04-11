//
//  AppCoordinator.swift
//  TokopediaMiniProject
//
//  Created by Santo Michael Sihombing on 10/04/22.
//

import Foundation
import UIKit
import Core

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
}

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    let window: UIWindow
    
    init(navigationController: UINavigationController,
         window: UIWindow) {
        self.navigationController = navigationController
        self.window = window
    }
    
    func start() {
        var coordinator: Coordinator?
        
        coordinator = HomeCoordinatorImplement(navigationController: navigationController)
        
        coordinator?.start()
        window.rootViewController = self.navigationController
        window.overrideUserInterfaceStyle = .light
        window.makeKeyAndVisible()
    }
}

