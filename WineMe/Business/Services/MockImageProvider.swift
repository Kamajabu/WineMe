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
        let rect = CGRect(origin: .zero, size: CGSize(width: 30, height: 30))
        UIGraphicsBeginImageContextWithOptions( CGSize(width: 30, height: 30), false, 0.0)
        UIColor.red.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
        
        return UIImage(imageLiteralResourceName: "WinePlaceholder")
    }
}
