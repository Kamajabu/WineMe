//
//  WineMeApp.swift
//  WineMe
//
//  Created by Kamajabu on 14/07/2024.
//

import SwiftUI

@main
struct WineMeApp: App {
    
    @StateObject var wineListViewModel = WineListViewModel(repository: NetworkWineRepository())
    @Environment(\.colorScheme) var colorScheme

    var body: some Scene {
        WindowGroup {
            WineListView(viewModel: wineListViewModel)
        }
    }
}
