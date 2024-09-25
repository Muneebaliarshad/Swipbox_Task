//
//  MovieDetailRepository.swift
//  Swipbox_Task
//
//  Created by Muneeb Ali on 24/09/2024.
//

import Foundation

protocol MovieDetailRepositoryProtocol: AnyObject {
    func fetchMovieData(movieID: Int, completion: @escaping (MovieDetail, String?) -> Void)
}

final class MovieDetailRepository: MovieDetailRepositoryProtocol {
    
    //MARK: - Variables
    private let networkService: NetworkService
    private let persistanceStore: PersistanceStore
    
    //MARK: - Init
    init(networkService: NetworkService, persistanceStore: PersistanceStore) {
        self.networkService = networkService
        self.persistanceStore = persistanceStore
    }
    
    func fetchMovieData(movieID: Int, completion: @escaping (MovieDetail, String?) -> Void) {
        if !Reachability.isConnectedToNetwork() {
            self.loadFromDB(movieID: movieID) { result in
                switch result {
                case .success(let moviesDetails):
                    completion(moviesDetails, nil)
                case .failure(let error):
                    let error = ErrorResponse(rawValue: (error as NSError).domain)
                    completion(MovieDetail(), error?.description)
                }
            }
        } else {
            self.fetchMoviesDataInternet(movieID: movieID) { result in
                switch result {
                case .success(let moviesDetails):
                    self.saveMovieData(movieData: moviesDetails)
                    completion(moviesDetails, nil)
                case .failure(let error):
                    let error = ErrorResponse(rawValue: (error as NSError).domain)
                    completion(MovieDetail(), error?.description)
                }
            }
        }
    }
    
    
    private func loadFromDB(movieID: Int, complete completion: @escaping (Result<MovieDetail, Error>) -> Void) {
        let movieData = persistanceStore.loadMoviesDetailData(movieID: movieID)
        completion(.success(movieData ?? MovieDetail()))
    }
    
    private func fetchMoviesDataInternet(movieID: Int, complete completion: @escaping (Result<MovieDetail, Error>) -> Void) {
        networkService.request(MovieDetailRequest(movieID: movieID)) { result in
            switch result {
            case .success(let movieDetails):
                completion(.success(movieDetails))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
                               
    func saveMovieData(movieData: MovieDetail) {
        persistanceStore.saveMovieDetailData(movieData: movieData)
    }
}
