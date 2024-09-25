//
//  AppDIContainer.swift
//  Swipbox_Task
//
//  Created by Muneeb Ali on 21/09/2024.
//

import Foundation

final class AppDIContainer {
    
    // MARK: - Properties
    lazy var networkService: NetworkService = {
        return DefaultNetworkService()
    }()
    lazy var persistanceStore: MoviesPersistanceStore = {
        return MoviesPersistanceStore()
    }()
    
    
    func makeSplashDIContainer() -> SplashDIContainer {
        let dependencies = SplashDIContainer.Dependencies(networkService: networkService)
        return SplashDIContainer(dependencies: dependencies)
    }
    
    func makeMoviesDIContainer() -> MoviesDIContainer {
        let dependencies = MoviesDIContainer.Dependencies(networkService: networkService, persistanceStore: persistanceStore)
        return MoviesDIContainer(dependencies: dependencies)
    }
    
    func makeMoviesDetailDIContainer(movieID: Int) -> MoviesDetailDIContainer {
        let dependencies = MoviesDetailDIContainer.Dependencies(networkService: networkService, persistanceStore: persistanceStore, movieID: movieID)
        return MoviesDetailDIContainer(dependencies: dependencies)
    }
}
