//
//  SplashDIContainer.swift
//  Swipbox_Task
//
//  Created by Muneeb Ali on 22/09/2024.
//

import UIKit

final class SplashDIContainer {
    
    //MARK: - Variables
    struct Dependencies {
        let networkService: NetworkService
    }
    private let dependencies: Dependencies
    
    
    //MARK: - Init
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    //MARK: - ViewController
    func makeSplashViewController(coordinator: AppCoordinator) -> SplashViewController {
        let splashVC = SplashViewController()
        splashVC.coordinator = coordinator
        return splashVC
    }
}
