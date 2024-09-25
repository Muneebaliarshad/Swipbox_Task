//
//  MovieDetailRequest.swift
//  Swipbox_Task
//
//  Created by Muneeb Ali on 24/09/2024.
//

import Foundation

struct MovieDetailRequest: DataRequest {
    var movieID = 0
    
    init(movieID: Int) {
        self.movieID = movieID
    }
    
    var url: String {
        let baseURL: String = AppConfiguration().apiBaseURL
        let path: String = "/movie/\(movieID)"
        return baseURL + path
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var queryItems: [String : String] {
        return [:]
    }
    
    func decode(_ data: Data) throws -> MovieDetail {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys
        let response = try decoder.decode(MovieDetail.self, from: data)
        return response
    }
}
