//
//  MockWineRepository.swift
//  WineMe
//
//  Created by Kamajabu on 14/07/2024.
//

import Foundation

final class MockWineRepository: WineRepository {
    
    static let mockWineArray: [WineDTO] = [
        WineDTO(
            winery: "Domaine de La Romanée-Conti",
            wine: "Montrachet Grand Cru 2010",
            rating: WineRating(average: "4.9", reviews: "37 ratings"),
            location: "France\n·\nMontrachet Grand Cru",
            image: "https://images.vivino.com/thumbs/rORmihtxSrKG7SfuI0bD6w_pb_x300.png",
            id: 1
        ),
        WineDTO(
            winery: "Domaine de La Romanée-Conti",
            wine: "Montrachet Grand Cru 2014",
            rating: WineRating(average: "4.9", reviews: "33 ratings"),
            location: "France\n·\nMontrachet Grand Cru",
            image: "https://images.vivino.com/thumbs/rORmihtxSrKG7SfuI0bD6w_pb_x300.png",
            id: 2
        ),
        WineDTO(
            winery: "Domaine Coche-Dury",
            wine: "Meursault Les Rougeots 2001",
            rating: WineRating(average: "4.9", reviews: "25 ratings"),
            location: "France\n·\nMeursault",
            image: "https://images.vivino.com/thumbs/l5W5NRvZR_SzClIDSnG5Ag_pb_x300.png",
            id: 3
        ),
        WineDTO(
            winery: "Domaine Coche-Dury",
            wine: "Corton-Charlemagne Grand Cru N.V.",
            rating: WineRating(average: "4.8", reviews: "416 ratings"),
            location: "France\n·\nCorton-Charlemagne Grand Cru",
            image: "https://images.vivino.com/thumbs/ZGxHdQyGQt-hfJt7eNMXlA_pb_x300.png",
            id: 4
        ),
        WineDTO(
            winery: "Jarvis",
            wine: "Estate Finch Hollow Chardonnay (Cave Fermented) 2014",
            rating: WineRating(average: "4.8", reviews: "113 ratings"),
            location: "United States\n·\nNapa Valley",
            image: "https://images.vivino.com/thumbs/pQ_92smWRKG7Y7h5_ZwD-w_pb_x300.png",
            id: 5
        )
    ]
    
    func fetchWines(type: WineType) async throws -> [WineDTO] {
        return MockWineRepository.mockWineArray
    }
    
    
}
