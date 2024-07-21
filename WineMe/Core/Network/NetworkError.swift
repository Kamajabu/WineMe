//
//  NetworkError.swift
//  WineMe
//
//  Created by Kamajabu on 14/07/2024.
//

import Foundation

enum NetworkError: LocalizedError {
    case requestDenied(code: Int)
    case invalidResponseFormat
    case invalidURL(url: String?)
    case decodingError(error: DecodingError)
    
    var errorDescription: String? {
        switch self {
        case .requestDenied(let code):
            "Request denied. Error code not within \(validStatus). Error code: \(code)"
        case .invalidResponseFormat:
            "Invalid response format"
        case .invalidURL(let urlString):
            "Invalid url. \(urlString ?? "-")"
        case .decodingError:
            "Decoding error"
        }
    }
    
}
