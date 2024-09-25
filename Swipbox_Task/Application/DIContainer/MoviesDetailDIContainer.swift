//
//  MoviesDetailDIContainer.swift
//  Swipbox_Task
//
//  Created by Muneeb Ali on 22/09/2024.
//

import UIKit

final class MoviesDetailDIContainer {
    
    //MARK: - Variables
    struct Dependencies {
        let networkService: NetworkService
        let persistanceStore: PersistanceStore
        let movieID: Int
    }
    private let dependencies: Dependencies
    
    
    //MARK: - Init
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    ///ViewController
    func makeMoviesDetailViewController(coordinator: AppCoordinator) -> MovieDetailViewController {
        let moviesVC = MovieDetailViewController()
        moviesVC.movieDetailVM = makeFetchMoviesDetailViewModel()
        return moviesVC
    }
    
    ///View Model
    private func makeFetchMoviesDetailViewModel() -> MovieDetailViewModel {
        let movieDetailViewModel = MovieDetailViewModel(movieDetailRepoProtocol: makeMoviesDetailRepository())
        movieDetailViewModel.movieID = dependencies.movieID
        return movieDetailViewModel
    }
    
    ///Repository
    private func makeMoviesDetailRepository() -> MovieDetailRepositoryProtocol {
        return MovieDetailRepository(networkService: dependencies.networkService, persistanceStore: dependencies.persistanceStore)
    }
}
