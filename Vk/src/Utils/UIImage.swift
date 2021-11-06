//
//  UIImage.swift
//  Vk
//
//  Created by Nihad on 11/6/21.
//

import Foundation
import UIKit

extension UIImage {
    static func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }

        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }

    func imageWith(newSize: CGSize, color: UIColor) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: newSize)
        var image = renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
        image = image.withTintColor(color)
        return image.withRenderingMode(self.renderingMode)
    }
}
