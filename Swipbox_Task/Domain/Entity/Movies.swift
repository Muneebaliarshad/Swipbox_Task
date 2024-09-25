//
//  Movies.swift
//  Swipbox_Task
//
//  Created by Muneeb Ali on 21/09/2024.
//

import Foundation

struct MoviesAPIResponse: Codable {
    var page: Int?
    var total_pages: Int?
    var total_results: Int?
    var results: [Movie]?
}

struct Movie: Codable, Equatable {
    var id: Int?
    var title: String?
    var poster_path: String?
    var release_date: String?
    var vote_average: Double?
    
    
    static func ==(lhs: Movie, rhs: Movie) -> Bool {
        if lhs.id == rhs.id {
            return true
        }
        return false
    }
}
