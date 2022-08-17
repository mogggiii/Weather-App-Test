//
//  SaveLocationTableViewCell.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/17/22.
//

import UIKit

class SavedLocationTableViewCell: UITableViewCell {
  
  // reuse id
  static let reuseId = "savedReuseId"
  
  // MARK: - UIComponents
  
  private let locationLabel: UILabel = {
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

// MARK: - Setup Views

extension SavedLocationTableViewCell {
  private func setupViews() {
    addSubview(locationLabel)
    backgroundColor = .white
    
    setupConstraints()
  }
  
  private func setupConstraints() {
    let locationNameLabelConstraints = [
      locationLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      locationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
      locationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
    ]
    
    NSLayoutConstraint.activate(locationNameLabelConstraints)
  }
}

// MARK: - Configure

extension SavedLocationTableViewCell {
  func configureWith(_ viewModel: SavedLocationViewModel) {
    locationLabel.text = viewModel.cityName
  }
}
