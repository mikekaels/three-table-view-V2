//
//  SceneDelegate.swift
//  TokopediaMiniProject
//
//  Created by Nakama on 06/11/20.
//

import UIKit
import Core
import CloudKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var appCoordinator: AppCoordinator?
    
    private var navigationController: UINavigationController = UINavigationController()
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        appCoordinator = AppCoordinator(navigationController: self.navigationController, window: window)
        appCoordinator?.start()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
         
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) { }
    
}
