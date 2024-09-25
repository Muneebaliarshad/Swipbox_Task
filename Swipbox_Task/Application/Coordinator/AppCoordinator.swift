//
//  AppCoordinator.swift
//  Swipbox_Task
//
//  Created by Muneeb Ali on 21/09/2024.
//

import UIKit

class AppCoordinator: Coordinator {
    
    enum Destination {
        case Splash
        case Movies
        case MoviesDetails(movieID: Int)
    }
    
    // MARK: - Properties
    private(set) var navigationController: NavigationController?
    private var appDIContainer: AppDIContainer
    
    // MARK: - Initializer
    init(navigationController: NavigationController, appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    // MARK: - Coordinator
    @discardableResult func start(from destination: Destination) -> UIViewController? {
        set(to: destination)
        return self.navigationController
    }
    
    @discardableResult func restart(from destination: Destination) -> UIViewController? {
        set(to: destination)
        return self.navigationController
    }
    
    func set(to destination: Destination) {
        let viewController = makeViewController(for: destination)
        navigationController?.setViewControllers([viewController], animated: false)
    }
    
    func push(to destination: Destination) {
        let viewController = makeViewController(for: destination)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func pop() {
        navigationController?.popViewController(animated: true)
    }
    
    func present(controller viewController: UIViewController) {
        navigationController?.present(viewController, animated: true)
    }
    
    func dismiss(animated: Bool = true, completion: @escaping () -> Void = {}) {
        self.navigationController?.dismiss(animated: animated, completion: completion)
    }
    
    func makeViewController(for destination: Destination) -> UIViewController {
        switch destination {
        case .Splash:
            let diContainer = appDIContainer.makeSplashDIContainer()
            let splashVC = diContainer.makeSplashViewController(coordinator: self)
            return splashVC
            
        case .Movies:
            let diContainer = appDIContainer.makeMoviesDIContainer()
            let movieVC = diContainer.makeMoviesViewController(coordinator: self)
            return movieVC
            
        case .MoviesDetails(movieID: let movieID):
            let diContainer = appDIContainer.makeMoviesDetailDIContainer(movieID: movieID)
            let movieDetailVC = diContainer.makeMoviesDetailViewController(coordinator: self)
            return movieDetailVC
        }
    }
}
