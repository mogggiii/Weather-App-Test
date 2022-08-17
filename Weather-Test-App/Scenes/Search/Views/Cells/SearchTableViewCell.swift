//
//  SearchTableViewCell.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/17/22.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
  
  // Cell reuse id
  static let reuseId = "searchReuseId"
  
  // MARK: - UIComponents
  
  private let locationNameLabel: UILabel = {
    let label = UILabel()
    label.textColor = .black
    label.font = .systemFont(ofSize: 20, weight: .semibold)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  // MARK: - Init
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

// MARK: - Setup views

extension SearchTableViewCell {
  private func setupViews() {
    addSubview(locationNameLabel)
    backgroundColor = .white
    
    setupConstraints()
  }
  
  private func setupConstraints() {
    let locationNameLabelConstraints = [
      locationNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      locationNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
      locationNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
    ]
    
    NSLayoutConstraint.activate(locationNameLabelConstraints)
  }
}

// MARK: - Configure Cell

extension SearchTableViewCell {
  func configureWith(_ title: String) {
    locationNameLabel.text = title
  }
}
