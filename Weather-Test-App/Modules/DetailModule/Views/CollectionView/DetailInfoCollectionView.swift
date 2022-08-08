//
//  DetailCollectionView.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/8/22.
//

import UIKit

class DetailInfoCollectionView: UICollectionView {
  
  // MARK: - Init
  override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    super.init(frame: frame, collectionViewLayout: layout)
  
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Setup Views

extension DetailInfoCollectionView {
  private func setupViews() {
    dataSource = self
    delegate = self
    backgroundColor = .clear
    
    registerCells()
  }
  
  private func registerCells() {
    register(HourlyCell.self, forCellWithReuseIdentifier: HourlyCell.reuseId)
    register(DetailCell.self, forCellWithReuseIdentifier: DetailCell.reuseId)
    register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseId)
  }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegateFlowLayout
extension DetailInfoCollectionView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    switch section {
//    case 0:
//      return 1
//    case 1:
//      return 2
//    default:
//      break
//    }
//    
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch indexPath.section {
    case 0:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyCell.reuseId, for: indexPath) as! HourlyCell
      return cell
    case 1:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCell.reuseId, for: indexPath) as! DetailCell
      return cell
    default:
      break
    }

    return UICollectionViewCell()
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 2
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    if kind == UICollectionView.elementKindSectionHeader {
      let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseId, for: indexPath) as! SectionHeader
      
      switch indexPath.section {
      case 0:
        sectionHeader.header.text = "Hourly"
      case 1:
        sectionHeader.header.text = "Detail Information"
      default:
        break
      }
      
      return sectionHeader
    }
    
    return UICollectionReusableView()
  }
}

extension DetailInfoCollectionView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    switch indexPath.section {
    case 0:
      return CGSize(width: UIScreen.main.bounds.width, height: 120)
    case 1:
      return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.40)
    default :
      break
    }
    return CGSize(width: 0, height: 0)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: 40)
  }
}

