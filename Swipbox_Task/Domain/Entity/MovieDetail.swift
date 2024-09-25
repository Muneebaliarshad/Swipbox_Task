//
//  MovieDetail.swift
//  Swipbox_Task
//
//  Created by Muneeb Ali on 22/09/2024.
//

import Foundation

struct MovieDetail: Codable, Equatable {
    var id: Int?
    var title: String?
    var backdrop_path: String?
    var poster_path: String?
    var release_date: String?
    var budget: Double?
    var overview: String?
    var revenue: Double?
    var vote_average: Double?
    
    
    static func ==(lhs: MovieDetail, rhs: MovieDetail) -> Bool {
        if lhs.id == rhs.id {
            return true
        }
        return false
    }
}
