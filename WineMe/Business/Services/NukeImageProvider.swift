//
//  NukeImageProvider.swift
//  WineMe
//
//  Created by Kamajabu on 15/07/2024.
//

import Foundation
import UIKit
import Nuke

final class NukeImageProvider: ImageDownloader {
    func downloadImage(url: URL) async throws -> UIImage {
        let imageTask = ImagePipeline.shared.imageTask(with: url)
        
        return try await imageTask.image
    }
}
