//
//  NetworkClient.swift
//  WineMe
//
//  Created by Kamajabu on 14/07/2024.
//

import Foundation

protocol NetworkClient {
    func makeRequest<DTO: Decodable>(target: NetworkTarget) async throws -> DTO
}
