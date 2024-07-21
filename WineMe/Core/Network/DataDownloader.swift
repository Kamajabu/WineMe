//
//  DataDownloader.swift
//  WineMe
//
//  Created by Kamajabu on 14/07/2024.
//

import Foundation

let validStatus = 200 ... 299

protocol DataDownloader {
    func httpData(from: URLRequest) async throws -> Data
}

extension URLSession: DataDownloader {
    func httpData(from request: URLRequest) async throws -> Data {
        guard let (data, response) = try await self.data(for: request) as? (Data, HTTPURLResponse) else {
            throw NetworkError.invalidResponseFormat
        }
        
        guard validStatus.contains(response.statusCode) else {
            throw NetworkError.requestDenied(code: response.statusCode)
        }
        
        return data
    }
}
