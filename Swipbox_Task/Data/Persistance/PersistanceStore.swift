//
//  PersistanceStore.swift
//  Swipbox_Task
//
//  Created by Muneeb Ali on 21/09/2024.
//

import Foundation
import CoreData

protocol PersistanceStore {
    func saveMoviesData(movies: [Movie])
    func loadMoviesData() -> [Movie]?
    func saveMovieDetailData(movieData: MovieDetail)
    func loadMoviesDetailData(movieID: Int) -> MovieDetail?
}

struct MoviesPersistanceStore: PersistanceStore {
    
    // MARK: - Properties
    let context = PersistentStorage.shared.context
    
    // MARK: - Methods
    func saveMoviesData(movies: [Movie]) {
        var newMovies = [Movie]()
        if let localMovies = loadMoviesData() {
            for newMovie in movies {
                if !localMovies.contains(where: {$0.id == newMovie.id && $0.id != nil}) {
                    newMovies.append(newMovie)
                }
            }
        }
        
        newMovies.forEach { movie in
            PersistentStorage.shared.persistentContainer.performBackgroundTask { privateManagedContext in
                let movieData = Movies(context: privateManagedContext)
                movieData.id = Int64(movie.id ?? 0)
                movieData.title = movie.title ?? ""
                movieData.poster_path = movie.poster_path ?? ""
                movieData.release_date = movie.release_date ?? ""
                movieData.vote_average = movie.vote_average ?? 0
                
                if privateManagedContext.hasChanges {
                    try? privateManagedContext.save()
                }
            }
        }
    }
    
    func loadMoviesData() -> [Movie]? {
        var movies: [Movie]? = nil
        
        context.performAndWait {
            let result = PersistentStorage.shared.fetchManagedObject(managedObject: Movies.self)
            movies = result?.map ({ movie in
                Movie(id: Int(movie.id),
                       title: movie.title,
                       poster_path: movie.poster_path,
                       release_date: movie.release_date,
                       vote_average: movie.vote_average)
            })
        }
        
        return movies
    }
    
    func saveMovieDetailData(movieData: MovieDetail) {
        var newMovieData = MovieDetail()
        if let localMovieData = loadMoviesDetailData(movieID: movieData.id ?? 0) {
            if localMovieData.id == movieData.id {
                newMovieData = movieData
            }
        }
        
        if newMovieData.id == nil {
            newMovieData = movieData
        }
        
        PersistentStorage.shared.persistentContainer.performBackgroundTask { privateManagedContext in
            let movieData = MovieData(context: privateManagedContext)
            movieData.id = Int64(newMovieData.id ?? 0)
            movieData.title = newMovieData.title ?? ""
            movieData.backdrop_path = newMovieData.title ?? ""
            movieData.poster_path = newMovieData.poster_path ?? ""
            movieData.release_date = newMovieData.release_date ?? ""
            movieData.budget = newMovieData.budget ?? 0
            movieData.overview = newMovieData.overview ?? ""
            movieData.revenue = newMovieData.revenue ?? 0
            movieData.vote_average = newMovieData.vote_average ?? 0
            
            if privateManagedContext.hasChanges {
                try? privateManagedContext.save()
            }
        }
    }
    
    func loadMoviesDetailData(movieID: Int) -> MovieDetail? {
        var movieData: MovieDetail? = nil
        
        context.performAndWait {
            let result = PersistentStorage.shared.fetchManagedObject(managedObject: MovieData.self, id: Int64(movieID))
            movieData = MovieDetail(id: Int(result?.first?.id ?? 0),
                                    title: result?.first?.title,
                                    backdrop_path: result?.first?.backdrop_path,
                                    poster_path: result?.first?.poster_path,
                                    release_date: result?.first?.release_date,
                                    budget: result?.first?.budget,
                                    overview: result?.first?.overview,
                                    revenue: result?.first?.revenue,
                                    vote_average: result?.first?.vote_average)

        }
        
        return movieData
    }
}


