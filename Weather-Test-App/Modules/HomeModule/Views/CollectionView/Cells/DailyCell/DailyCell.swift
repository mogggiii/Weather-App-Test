//
//  DailyCell.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/7/22.
//

import Foundation
import UIKit

class DailyCell: UICollectionViewCell {
  
  /// reuse id
  static let reuseId = "dailyCollectionCell"
  
  // MARK: - Collectrion View
  
  lazy var dailyCollectionView: DailyCollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = 10
    layout.minimumInteritemSpacing = 10
    let view = DailyCollectionView(frame: .zero, collectionViewLayout: layout)
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

extension DailyCell {
  private func setupView() {
    backgroundColor = .clear
    addSubview(dailyCollectionView)
    
    setupConstraints()
  }
  
  private func setupConstraints() {
    let dailyCollectionViewConstraint = [
      dailyCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
      dailyCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      dailyCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      dailyCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
    ]
    
    NSLayoutConstraint.activate(dailyCollectionViewConstraint)
  }
}
