//
//  WineType.swift
//  WineMe
//
//  Created by Kamajabu on 14/07/2024.
//

import Foundation
import SwiftUI


enum WineType: String, CaseIterable, Identifiable {
    case reds
    case whites
    case sparkling
    case rose
    case dessert
    case port
    
    var id: String { self.rawValue }
    
    var name: String { self.rawValue.capitalized }
    
    var gradientColors: [Color] {
        switch self {
        case .reds:
            return [Color.red, Color.burgundy]
        case .whites:
            return [Color.white, Color.yellow]
        case .sparkling:
            return [Color.yellow, Color.white]
        case .rose:
            return [Color.pink, Color.orange]
        case .dessert:
            return [Color.orange, Color.brown]
        case .port:
            return [Color.purple, Color.darkPurple]
        }
    }
}

extension WineType: CirclePickerOption {
    var label: String {
        self.name
    }
}
