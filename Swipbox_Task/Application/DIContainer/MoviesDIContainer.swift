//
//  MoviesDIContainer.swift
//  Swipbox_Task
//
//  Created by Muneeb Ali on 22/09/2024.
//

import UIKit

final class MoviesDIContainer {
    
    //MARK: - Variables
    struct Dependencies {
        let networkService: NetworkService
        let persistanceStore: PersistanceStore
    }
    private let dependencies: Dependencies
    
    
    //MARK: - Init
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    ///ViewController
    func makeMoviesViewController(coordinator: AppCoordinator) -> MoviesViewController {
        let moviesVC = MoviesViewController()
        moviesVC.coordinator = coordinator
        moviesVC.moviesVM = makeFetchMoviesViewModel()
        return moviesVC
    }
    
    ///View Model
    private func makeFetchMoviesViewModel() -> MoviesViewModel {
        return MoviesViewModel(moviesRepoProtocol: makeMoviesRepository())
    }
    
    ///Repository
    private func makeMoviesRepository() -> MoviesRepositoryProtocol {
        return MoviesRepository(networkService: dependencies.networkService, persistanceStore: dependencies.persistanceStore)
    }
}
