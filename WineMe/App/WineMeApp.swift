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
    
    var body: some Scene {
        WindowGroup {
            WineListView(viewModel: wineListViewModel)
        }
    }
}
