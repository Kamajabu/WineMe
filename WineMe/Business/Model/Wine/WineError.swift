//
//  WineError.swift
//  WineMe
//
//  Created by Kamajabu on 14/07/2024.
//

import Foundation

struct WineError: Decodable {
    let error: Int
    let message: String
}
