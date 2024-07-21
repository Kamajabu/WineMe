//
//  WineNetworkClient.swift
//  WineMe
//
//  Created by Kamajabu on 14/07/2024.
//

import Foundation

enum WineNetworkError: LocalizedError {
    case wineResponseError(error: WineError)
    
    var errorDescription: String? {
        switch self {
        case .wineResponseError(let error):
            "Wine response error: \(error.message). Code: \(error.error)"
        }
    }
}

actor WineNetworkClient: NetworkClient {
    
    private let baseURL = "api.sampleapis.com"
    
    private let downloader: any DataDownloader
    
    private lazy var decoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        return jsonDecoder
    }()
    
    private lazy var encoder: JSONEncoder = {
        let jsonEncoder = JSONEncoder()
        return jsonEncoder
    }()
    
    init(downloader: any DataDownloader = URLSession.shared) {
        self.downloader = downloader
    }
    
    func makeRequest<DTO: Decodable>(target: any NetworkTarget) async throws -> DTO {
        var urlRequest = try target.composeURLRequest(baseURL: baseURL)
        
        if let body = target.body {
            urlRequest.httpBody = try encoder.encode(body)
        }
        
        let data = try await downloader.httpData(from: urlRequest)
        
        return try decode(data)
    }
    
    private func decode<DTO: Decodable>(_ data: Data) throws -> DTO {
        do {
            return try decoder.decode(DTO.self, from: data)
        } catch let error as DecodingError {
            throw NetworkError.decodingError(error: error)
        } catch {
            if let decodedError = fallbackToError(data) {
                throw WineNetworkError.wineResponseError(error: decodedError)
            } else {
                throw error
            }
        }
    }
    
    private func fallbackToError(_ data: Data) -> WineError? {
        do {
            return try decoder.decode(WineError.self, from: data)
        } catch {
            return nil
        }
    }
}
