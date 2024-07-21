//
//  AppColorScheme.swift
//  WineMe
//
//  Created by Kamajabu on 21/07/2024.
//

import Foundation
import SwiftUI

enum AppColorScheme: String {
    case dark
    case light
    
    init(systemScheme: ColorScheme) {
        switch systemScheme {
        case .light:
            self = .light
        case .dark:
            self = .dark
        @unknown default:
            assertionFailure("Some new color was added to system")
            self = .dark
        }
    }

    var systemScheme: ColorScheme {
        switch self {
        case .dark:
            .dark
        case .light:
            .light
        }
    }
    
    var label: String {
        self.rawValue.capitalized
    }
}
