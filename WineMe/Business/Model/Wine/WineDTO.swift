//
//  WineDTO.swift
//  WineMe
//
//  Created by Kamajabu on 14/07/2024.
//

import Foundation

struct WineDTO: Codable, Equatable, Hashable {
    let winery: String
    let wine: String
    let rating: WineRating
    let location: String
    let image: String // try to add custom mapping
    let id: Int
}

struct WineRating: Codable, Equatable, Hashable {
    let average: String
    let reviews: String
}

extension WineDTO: CirclePickerOption {
    var label: String {
        wine
    }
}
