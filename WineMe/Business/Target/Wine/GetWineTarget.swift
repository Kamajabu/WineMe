//
//  GetWineTarget.swift
//  WineMe
//
//  Created by Kamajabu on 14/07/2024.
//

import Foundation

struct GetWineTarget: NetworkTarget {
    var path: String { "/wines/\(wineType.rawValue)/"}
    
    var method: HTTPMethod = .get
    
    var queryItems: [URLQueryItem]? = nil

    var body: Encodable? = nil
    
    var wineType: WineType
}
