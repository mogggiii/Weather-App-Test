//
//  CollectionView.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/6/22.
//

import Foundation
import UIKit

class CollectionView: UICollectionView {
  
  var detailInfoCollectionDidLoad: ((DetailCell) -> Void)?
  var hourlyCollectionDidLoad: ((HourlyCell) ->())?
  var dailyCollectionDidLoad: ((DailyCell) -> ())?
  
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

extension CollectionView {
  private func setupViews() {
    dataSource = self
    delegate = self
    backgroundColor = .clear
    
    registerCells()
  }
  
  private func registerCells() {
    register(HourlyCell.self, forCellWithReuseIdentifier: HourlyCell.reuseId)
    register(DailyCell.self, forCellWithReuseIdentifier: DailyCell.reuseId)
    register(DetailCell.self, forCellWithReuseIdentifier: DetailCell.reuseId)
    register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseId)
  }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegateFlowLayout
extension CollectionView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch indexPath.section {
    case 0:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyCell.reuseId, for: indexPath) as! HourlyCell
      if let hourlyCollectionDidLoad = hourlyCollectionDidLoad {
        hourlyCollectionDidLoad(cell)
      } else {
        return cell
      }
      
      return cell
    case 1:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCell.reuseId, for: indexPath) as! DetailCell
      if let detailInfoCollectionDidLoad = detailInfoCollectionDidLoad {
        detailInfoCollectionDidLoad(cell)
      } else {
        return cell
      }
      
      return cell
    case 2:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyCell.reuseId, for: indexPath) as! DailyCell
      if let dailyCollectionDidLoad = dailyCollectionDidLoad{
        dailyCollectionDidLoad(cell)
      } else {
        return cell
      }
      
      return cell
    default:
      return UICollectionViewCell()
    }
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 3
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
        sectionHeader.header.text = "Daily"
      }
      
      return sectionHeader
    }
    
    return UICollectionReusableView()
  }
}

extension CollectionView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    switch indexPath.section {
    case 0:
      return CGSize(width: UIScreen.main.bounds.width, height: 120)
    case 1:
      return CGSize(width: UIScreen.main.bounds.width, height: 165)
    default :
      return CGSize(width: UIScreen.main.bounds.width - 32, height: UIScreen.main.bounds.height * 0.75)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: 40)
  }
}
