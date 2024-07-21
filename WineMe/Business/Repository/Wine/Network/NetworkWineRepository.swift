//
//  NetworkWineRepository.swift
//  WineMe
//
//  Created by Kamajabu on 14/07/2024.
//

import Foundation

final class NetworkWineRepository: WineRepository {
    private let client = WineNetworkClient()
    
    func fetchWines(type: WineType) async throws -> [WineDTO] {
        let target = GetWineTarget(wineType: type)
        return try await client.makeRequest(target: target)
    }
}
