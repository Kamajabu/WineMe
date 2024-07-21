//
//  NetworkTarget.swift
//  WineMe
//
//  Created by Kamajabu on 14/07/2024.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

protocol NetworkTarget {
    /// format: "/path/"
    var path: String { get }
    var method: HTTPMethod { get }
    
    var queryItems: [URLQueryItem]? { get }
    var body: Encodable? { get }
}

extension NetworkTarget {
    func composeURLRequest(baseURL: String, scheme: String = "https") throws -> URLRequest {
        var components = URLComponents()
        components.host = baseURL
        components.path = path
        components.scheme = scheme
        components.queryItems = queryItems
        
        guard let url = components.url else { throw NetworkError.invalidURL(url: components.description)}
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        return request
    }
}
