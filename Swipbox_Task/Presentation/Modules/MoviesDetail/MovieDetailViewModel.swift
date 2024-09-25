//
//  MoviesDetailViewModel.swift
//  Swipbox_Task
//
//  Created by Muneeb Ali on 22/09/2024.
//

import Foundation

protocol MovieDetailViewModelDelegate {
    func didUpdateValue(_ message: String)
}

class MovieDetailViewModel {
    
    //MARK: - Variables
    private let movieDetailRepoProtocol: MovieDetailRepositoryProtocol
    var moviesData: MovieDetail?
    var movieID = 0
    var movieDetailDelegate: MovieDetailViewModelDelegate?
    
    //MARK: - Init
    init(movieDetailRepoProtocol: MovieDetailRepositoryProtocol) {
        self.movieDetailRepoProtocol = movieDetailRepoProtocol
    }
    
    
    //MARK: - Service Methods
    func fetchMoviesList() {
        movieDetailRepoProtocol.fetchMovieData(movieID: movieID) { (data,message)  in
            if let message {
                self.movieDetailDelegate?.didUpdateValue(message)
            } else {
                self.moviesData = data
                self.movieDetailDelegate?.didUpdateValue("")
            }
        }
    }
}
