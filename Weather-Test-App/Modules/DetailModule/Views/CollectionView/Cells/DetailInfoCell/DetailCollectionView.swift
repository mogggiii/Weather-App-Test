//
//  DetailCollectionView.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/8/22.
//

import UIKit

class DetailCollectionView: UICollectionView {
  
  // MARK: - Init
  
  override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    super.init(frame: frame, collectionViewLayout: layout)
    
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup Views
  
  private func setupViews() {
    backgroundColor = .clear
    allowsSelection = false
    isScrollEnabled = false
    dataSource = self
    delegate = self
    register(DetailCollectionViewCell.self, forCellWithReuseIdentifier: DetailCollectionViewCell.reuseId)
  }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegateFlowLayout

extension DetailCollectionView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 4
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCollectionViewCell.reuseId, for: indexPath) as? DetailCollectionViewCell else { return UICollectionViewCell() }
    return cell
  }
}

extension DetailCollectionView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: (self.frame.width - 10) / 2, height: 75)
  }
}

