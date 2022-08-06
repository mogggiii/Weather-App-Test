//
//  CollectionView.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/6/22.
//

import Foundation
import UIKit

class CollectionView: UICollectionView {
  
  override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    super.init(frame: frame, collectionViewLayout: layout)
    
    dataSource = self
    delegate = self
    
    registerCells()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func registerCells() {
    register(HourlyCell.self, forCellWithReuseIdentifier: HourlyCell.reuseId)
    register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseId)
  }
  
}

extension CollectionView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyCell.reuseId, for: indexPath) as! HourlyCell
    return cell
    //    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyCell.reuseId, for: indexPath) as? HourlyCell else { return UICollectionViewCell() }
    //    let auf = collectionView.cell
    //    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UICollectionViewCell
    //    cell.backgroundColor = .black
    //    return UICollectionViewCell()
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

extension CollectionView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: UIScreen.main.bounds.width, height: 120)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: 40)
  }
}
