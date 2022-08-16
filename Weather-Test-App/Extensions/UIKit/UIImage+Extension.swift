//
//  UIImage+Extension.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/8/22.
//

import UIKit

extension UIImage {
  static func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {
    let scale = newWidth / image.size.width
    let newHeight = image.size.height * scale
    UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
    image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
    
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage
  }
}
