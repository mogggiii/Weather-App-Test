//
//  HourlyCell.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/6/22.
//

import Foundation
import UIKit

class HourlyCell: UICollectionViewCell {
  
  /// reuse id
  static let reuseId = "hourlyCollectionCell"
  
  // MARK: - CollectionView
  lazy var hourlyCollectionView: HourlyCollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.minimumLineSpacing = 10
    layout.minimumInteritemSpacing = 10
    let view = HourlyCollectionView(frame: .zero, collectionViewLayout: layout)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  // MARK: - Init
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Setup Views

extension HourlyCell {
  private func setupView() {
    backgroundColor = .clear
    addSubview(hourlyCollectionView)
    
    setupConstraints()
  }
  
  private func setupConstraints() {
    let hourlyCollectionViewConstraint = [
      hourlyCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
      hourlyCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
      hourlyCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
      hourlyCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
    ]
    
    NSLayoutConstraint.activate(hourlyCollectionViewConstraint)
  }
}
