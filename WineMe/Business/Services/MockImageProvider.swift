//
//  MockImageProvider.swift
//  WineMe
//
//  Created by Kamajabu on 15/07/2024.
//

import Foundation
import UIKit

final class MockImageProvider: ImageDownloader {
    func downloadImage(url: URL) async throws -> UIImage {
        UIImage(resource: .winePlaceholder)
    }
}
