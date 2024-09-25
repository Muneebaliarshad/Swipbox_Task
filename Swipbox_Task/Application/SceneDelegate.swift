//
//  SceneDelegate.swift
//  Swipbox_Task
//
//  Created by Muneeb Ali on 21/09/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    //MARK: - Variables
    var window: UIWindow?
    var appCoodinator: AppCoordinator?
    let appDIContainer = AppDIContainer()
    
    
    //MARK: - Life Cycle Methods
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        let navigationController = NavigationController()
        self.window?.rootViewController = navigationController
        appCoodinator = AppCoordinator(navigationController: navigationController, appDIContainer: appDIContainer)
        appCoodinator?.start(from: .Splash)
        self.window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
    }

}
