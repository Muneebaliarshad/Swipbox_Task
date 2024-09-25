//
//  MoviesRequest.swift
//  Swipbox_Task
//
//  Created by Muneeb Ali on 22/09/2024.
//

import Foundation

struct MoviesRequest: DataRequest {
    var page = "1"
    
    init(page: String) {
        self.page = page
    }
    
    var url: String {
        let baseURL: String = AppConfiguration().apiBaseURL
        let path: String = "/movie/popular"
        return baseURL + path
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var queryItems: [String : String] {
        return ["page": page]
    }
    
    func decode(_ data: Data) throws -> [Movie] {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys
        let response = try decoder.decode(MoviesAPIResponse.self, from: data)
        return response.results ?? [Movie()]
    }
}
