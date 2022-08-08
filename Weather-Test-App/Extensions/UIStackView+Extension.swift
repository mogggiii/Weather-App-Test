//
//  UIStackView+Extension.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/8/22.
//

import Foundation
import UIKit

extension UIStackView {
  static func generateStackView(arrangeSubviews: [UIView], spacing: CGFloat?, axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution) -> UIStackView {
    let stackView = UIStackView(arrangedSubviews: arrangeSubviews)
    stackView.spacing = spacing ?? 0
    stackView.axis = axis
    stackView.distribution = distribution
    stackView.translatesAutoresizingMaskIntoConstraints = false
    
    return stackView
  }
}
