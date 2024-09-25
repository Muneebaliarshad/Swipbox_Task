//
//  ErrorResponse.swift
//  Swipbox_Task
//
//  Created by Muneeb Ali on 21/09/2024.
//

import Foundation

enum ErrorResponse: String {
    case apiKey
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
    
    public var description: String {
        switch self {
        case .apiKey: return "Invalid API key: You must be granted a valid key."
        case .apiError: return "Ooops, there is something problem with the api"
        case .invalidEndpoint: return "Ooops, there is something problem with the endpoint"
        case .invalidResponse: return "Ooops, there is something problem with the response"
        case .noData: return "Ooops, there is something problem with the data"
        case .serializationError: return "Ooops, there is something problem with the serialization process"
        }
    }
}
