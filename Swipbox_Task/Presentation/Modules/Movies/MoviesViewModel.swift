//
//  MoviesViewModel.swift
//  Swipbox_Task
//
//  Created by Muneeb Ali on 22/09/2024.
//

import Foundation

protocol MoviesViewModelDelegate {
    func didUpdateValue(_ message: String)
}

class MoviesViewModel {
    
    //MARK: - Variables
    private let moviesRepoProtocol: MoviesRepositoryProtocol
    var moviesData: [Movie]?
    var pageNumber = 1
    var moviesDelegate: MoviesViewModelDelegate?
    
    
    //MARK: - Init
    init(moviesRepoProtocol: MoviesRepositoryProtocol) {
        self.moviesRepoProtocol = moviesRepoProtocol
    }
    
    
    //MARK: - Service Methods
    func fetchMoviesList() {
        moviesRepoProtocol.fetchMovies(pageNumber: pageNumber) { (data,message)  in
            if let message {
                self.moviesDelegate?.didUpdateValue(message)
            } else {
                self.moviesData = data
                self.pageNumber += 1
                self.moviesDelegate?.didUpdateValue("")
            }
        }
    }
}
