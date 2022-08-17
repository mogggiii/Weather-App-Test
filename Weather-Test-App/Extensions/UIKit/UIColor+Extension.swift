//
//  UIColor+Extension.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/8/22.
//

import UIKit

extension UIView {
  static func gradientColor(startColor: UIColor, endColor: UIColor, frame: CGRect) -> UIColor? {
    let gradient = CAGradientLayer(layer: frame.size)
    gradient.frame = frame
    gradient.colors = [startColor.cgColor, endColor.cgColor]
    gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
    gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
    UIGraphicsBeginImageContext(frame.size)
    guard let context = UIGraphicsGetCurrentContext() else { return nil }
    gradient.render(in: context)
    guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
    UIGraphicsEndImageContext()
    return UIColor(patternImage: image)
  }
}
