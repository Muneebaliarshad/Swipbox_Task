//
//  MoviesDetailViewController.swift
//  Swipbox_Task
//
//  Created by Muneeb Ali on 22/09/2024.
//

import UIKit

class MovieDetailViewController: UIViewController, MovieDetailViewModelDelegate {
    
    //MARK: - UIElements
    let detailView: MovieDetailView = {
        let view = MovieDetailView(backgroundColor: .clear)
        view.setView()
        return view
    }()
    
    //MARK: - Variables
    var movieDetailVM: MovieDetailViewModel?
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setViewUI()
    }
    
    
    //MARK: - Setup Methods
    func setViewUI() {
        addElementsToView()
        movieDetailVM?.movieDetailDelegate = self
        movieDetailVM?.fetchMoviesList()
    }
    
    fileprivate func addElementsToView() {
        view.addSubview(detailView)
        
        NSLayoutConstraint.activate([
            ///contentImageView
            detailView.topAnchor.constraint(equalTo: view.topAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
        ])
    }

    
    //MARK: - MovieDetailViewModelDelegate
    func didUpdateValue(_ message: String) {
        if message == "" {
            self.detailView.setData(self.movieDetailVM?.moviesData)
        } else {
            AlertBuilder.failureAlertWithMessage(message: message)
        }
    }
}
