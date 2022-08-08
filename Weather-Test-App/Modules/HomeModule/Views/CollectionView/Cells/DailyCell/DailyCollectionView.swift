//
//  DailyCollectionView.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/7/22.
//

import Foundation
import UIKit

class DailyCollectionView: UICollectionView {
  
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
    register(DailyCollectionViewCell.self, forCellWithReuseIdentifier: DailyCollectionViewCell.reuseId)
  }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegateFlowLayout

extension DailyCollectionView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 7
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyCollectionViewCell.reuseId, for: indexPath) as? DailyCollectionViewCell else { return UICollectionViewCell() }
    return cell
  }
}

extension DailyCollectionView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: self.frame.width, height: 75)
  }
}
