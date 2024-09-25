//
//  MoviesViewController.swift
//  Swipbox_Task
//
//  Created by Muneeb Ali on 22/09/2024.
//

import UIKit

class MoviesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, MoviesViewModelDelegate {
    
    //MARK: - UIElements
    var collectionView : CollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        layout.scrollDirection = .vertical
        
        let cv = CollectionView(layout: layout)
        cv.register(MovieListCollectionViewCell.self, forCellWithReuseIdentifier: MovieListCollectionViewCell.identifier)
        return cv
    }()
    
    
    //MARK: - Variables
    var coordinator: AppCoordinator!
    var moviesVM: MoviesViewModel?
    
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewUI()
    }
    
    
    //MARK: - Setup Methods
    func setViewUI() {
        navigationItem.title = "Movies"
        view.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        addElementsToView()
        moviesVM?.moviesDelegate = self
        moviesVM?.fetchMoviesList()
    }
    
    fileprivate func addElementsToView() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            ///collectionView
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    

    //MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesVM?.moviesData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionViewCell.identifier, for: indexPath) as! MovieListCollectionViewCell
        cell.setData(moviesVM!.moviesData![indexPath.row])
        return cell
    }
    
    
    //MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.coordinator.push(to: .MoviesDetails(movieID: moviesVM!.moviesData![indexPath.row].id ?? 0))
    }
    
    
    //MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 2) - 20, height: (collectionView.frame.height / 2.5))
    }
    
    
    //MARK: - MoviesViewModelDelegate
    func didUpdateValue(_ message: String) {
        if message == "" {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        } else {
            AlertBuilder.failureAlertWithMessage(message: message)
        }
    }
}
