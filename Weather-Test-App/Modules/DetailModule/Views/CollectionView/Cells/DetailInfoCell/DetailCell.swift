//
//  DetailCell.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/8/22.
//

import UIKit

class DetailCell: UICollectionViewCell {
  
  /// reuse id
  static let reuseId = "detailCollectionCell"
  
  // MARK: - Collectrion View
  
  lazy var detailCollectionView: DetailCollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = 10
    layout.minimumInteritemSpacing = 10
    let view = DetailCollectionView(frame: .zero, collectionViewLayout: layout)
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

extension DetailCell {
  private func setupView() {
    backgroundColor = .clear
    addSubview(detailCollectionView)
    
    setupConstraints()
  }
  
  private func setupConstraints() {
    let detailCollectionViewConstraint = [
      detailCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
      detailCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
      detailCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
      detailCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
    ]
    
    NSLayoutConstraint.activate(detailCollectionViewConstraint)
  }
}
