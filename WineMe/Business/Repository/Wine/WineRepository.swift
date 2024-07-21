//
//  WineRepository.swift
//  WineMe
//
//  Created by Kamajabu on 14/07/2024.
//

import Foundation

protocol WineRepository {
    func fetchWines(type: WineType) async throws -> [WineDTO]
}
