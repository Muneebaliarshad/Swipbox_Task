//
//  MoviesRepository.swift
//  Swipbox_Task
//
//  Created by Muneeb Ali on 22/09/2024.
//

import Foundation

protocol MoviesRepositoryProtocol: AnyObject {
    func fetchMovies(pageNumber: Int, completion: @escaping ([Movie], String?) -> Void)
}

final class MoviesRepository: MoviesRepositoryProtocol {
    
    //MARK: - Variables
    private let networkService: NetworkService
    private let persistanceStore: PersistanceStore
    
    //MARK: - Init
    init(networkService: NetworkService, persistanceStore: PersistanceStore) {
        self.networkService = networkService
        self.persistanceStore = persistanceStore
    }
    
    func fetchMovies(pageNumber: Int, completion: @escaping ([Movie], String?) -> Void) {
        if !Reachability.isConnectedToNetwork() {
            self.loadFromDB { result in
                switch result {
                case .success(let moviesDetails):
                    completion(moviesDetails, nil)
                case .failure(let error):
                    let error = ErrorResponse(rawValue: (error as NSError).domain)
                    completion([], error?.description)
                }
            }
        } else {
            self.fetchMoviesDataInternet(pageNumber: pageNumber) { result in
                switch result {
                case .success(let moviesDetails):
                    self.saveMovies(movies: moviesDetails)
                    completion(moviesDetails, nil)
                case .failure(let error):
                    let error = ErrorResponse(rawValue: (error as NSError).domain)
                    completion([], error?.description)
                }
            }
        }
    }
    
    
    private func loadFromDB(complete completion: @escaping (Result<[Movie], Error>) -> Void) {
        let movies = persistanceStore.loadMoviesData()
        completion(.success(movies ?? []))
    }
    
    private func fetchMoviesDataInternet(pageNumber: Int, complete completion: @escaping (Result<[Movie], Error>) -> Void) {
        networkService.request(MoviesRequest(page: pageNumber.description)) { result in
            switch result {
            case .success(let movieDetails):
                completion(.success(movieDetails))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func saveMovies(movies: [Movie]) {
        persistanceStore.saveMoviesData(movies: movies)
        movies.forEach { movie in
            ImageDownloadService.getImage(urlString: AppConfiguration().bannerImageBaseURL + (movie.poster_path ?? "")) { imag in
                print("ndjdj")
            }
        }
    }
}
