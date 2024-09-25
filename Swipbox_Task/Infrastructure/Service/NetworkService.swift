//
//  NetworkService.swift
//  Swipbox_Task
//
//  Created by Muneeb Ali on 21/09/2024.
//

import Foundation

protocol NetworkService {
    func request<Request: DataRequest>(_ request: Request, completion: @escaping (Result<Request.Response, Error>) -> Void)
}

final class DefaultNetworkService: NetworkService {
    
    func request<Request: DataRequest>(_ request: Request, completion: @escaping (Result<Request.Response, Error>) -> Void) {
        
        guard var urlComponent = URLComponents(string: request.url) else {
            let error = createError(domain: ErrorResponse.invalidEndpoint, code: 404)
            return completion(.failure(error))
        }
        
        var queryItems: [URLQueryItem] = []
        request.queryItems.forEach {
            let urlQueryItem = URLQueryItem(name: $0.key, value: $0.value)
            urlComponent.queryItems?.append(urlQueryItem)
            queryItems.append(urlQueryItem)
        }
        
        urlComponent.queryItems = queryItems
        
        guard let url = urlComponent.url else {
            let error = createError(domain: ErrorResponse.invalidEndpoint, code: 404)
            return completion(.failure(error))
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                return completion(.failure(error))
            }
            
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                let error = self.createError(domain: ErrorResponse.apiKey, code: 401)
                return completion(.failure(error))
            }
            
            guard let data = data else {
                return completion(.failure(NSError()))
            }
            
            do {
                let decodedData = try request.decode(data)
                completion(.success(decodedData))
            } catch let error as NSError {
                completion(.failure(error))
            }
        }
        .resume()
    }
    
    func createError(domain: ErrorResponse, code: Int, userInfo: [String: Any]? = nil) -> NSError {
        return NSError(domain: domain.rawValue, code: code, userInfo: userInfo)
    }
}
