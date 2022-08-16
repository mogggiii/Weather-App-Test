//
//  SectionHeader.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/6/22.
//

import Foundation
import UIKit

class SectionHeader: UICollectionReusableView {
  
  /// reuse id
  static let reuseId = "headerId"
  
  // MARK: - UIComponents
  var header: UILabel = {
    let label: UILabel = UILabel()
    label.textColor = .black
    label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.sizeToFit()
    return label
  }()
  
  // MARK: - Init
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Setup Views

extension SectionHeader {
  private func setupViews() {
    addSubview(header)
    setupConstraints()
  }
  
  private func setupConstraints() {
    let headerConstraints = [
      header.topAnchor.constraint(equalTo: self.topAnchor),
      header.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
      header.rightAnchor.constraint(equalTo: self.rightAnchor),
    ]
    
    NSLayoutConstraint.activate(headerConstraints)
  }
}
