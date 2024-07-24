//
//  WineListViewModel.swift
//  WineMe
//
//  Created by Kamajabu on 14/07/2024.
//

import Foundation
import OSLog

@MainActor
final class WineListViewModel: ObservableObject {
    private let repository: WineRepository
    
    private let logger = Logger(subsystem: "WineList", category: "ViewModel")
    
    @Published var error: String?
    @Published var wines: [WineDTO] = []
    
    @Published var isLoading = false
    
    private var currentlyDisplayedType: WineType?
    
    init(repository: WineRepository) {
        self.repository = repository
    }
    
    func downloadWines(type: WineType) async {
        guard type != currentlyDisplayedType else { return }
        
        isLoading = true
        self.wines = []
        
        defer {
            isLoading = false
        }
        
        do {
            self.wines = try await repository.fetchWines(type: type)
            currentlyDisplayedType = type
        } catch {
            logger.error("\(error.localizedDescription)")
            self.error = error.localizedDescription
        }
    }
}
