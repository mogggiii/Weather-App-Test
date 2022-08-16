//
//  DetailCollectionViewCell.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/8/22.
//

import Foundation
import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
  
  /// reuse id
  static let reuseId = "detailCell"
  
  // MARK: - UI Components
  
  private let subInfoTitles = ["Humidity", "Pressure", "Wind Speed", "Visibility"]
  
  private let weatherImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  private let topLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 14, weight: .semibold)
    label.textColor = .black
    label.text = "940 hPa"
    return label
  }()
  
  private let bottomLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 13, weight: .regular)
    label.textColor = .black
    label.text = "Presure"
    return label
  }()
  
  // MARK: - Init
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Setup Views

extension DetailCollectionViewCell {
  private func setupViews() {
    layer.cornerRadius = 12
    layer.masksToBounds = true
    backgroundColor = UIColor(red: 250 / 255, green: 250 / 255, blue: 250 / 255, alpha: 1)
    addSubview(weatherImageView)
    
    setupConstraints()
  }
  
  private func setupConstraints() {
    let weatherImageViewConstraints = [
      weatherImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      weatherImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
      weatherImageView.heightAnchor.constraint(equalToConstant: 24),
      weatherImageView.widthAnchor.constraint(equalToConstant: 24),
    ]
    
    NSLayoutConstraint.activate(weatherImageViewConstraints)
    
    setupLabelsConstraints()
  }
  
  private func setupLabelsConstraints() {
    let stackView = UIStackView.generateStackView(arrangeSubviews: [topLabel, bottomLabel], spacing: 4, axis: .vertical, distribution: .fillEqually)
    addSubview(stackView)
    
    let stackViewConstraints = [
      stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      stackView.leadingAnchor.constraint(equalTo: weatherImageView.trailingAnchor, constant: 16),
      stackView.heightAnchor.constraint(equalToConstant: 50)
    ]
    
    NSLayoutConstraint.activate(stackViewConstraints)
  }
}

extension DetailCollectionViewCell {
  func configureCell(viewModel: WeatherInfoViewModel, item: Int) {
    self.weatherImageView.image = UIImage(named: subInfoTitles[item])
    self.bottomLabel.text = subInfoTitles[item]
    self.topLabel.text = viewModel.infos[item]
  }
}
