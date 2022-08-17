//
//  DailyCollectionViewCell.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/7/22.
//

import UIKit

class DailyCollectionViewCell: UICollectionViewCell {
  
  /// reuse id
  static let reuseId = "dailyCell"
  
  // MARK: - UI Components
  
  private let weatherImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .center
    imageView.layer.cornerRadius = 25
    imageView.backgroundColor = UIColor(red: 154 / 255, green: 182 / 255, blue: 255 / 255, alpha: 1)
    imageView.clipsToBounds = true
    return imageView
  }()
  
  private let dayLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 14, weight: .semibold)
    label.textColor = .black
    return label
  }()
  
  private let tempMaxLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 14, weight: .semibold)
    label.textColor = .black
    return label
  }()
  
  private let tempMinLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 14, weight: .semibold)
    label.textColor = .gray
    return label
  }()
  
  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 13, weight: .regular)
    label.textColor = UIColor(red: 73 / 255, green: 67 / 255, blue: 67 / 255, alpha: 1)
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

extension DailyCollectionViewCell {
  private func setupViews() {
    layer.cornerRadius = 12
    layer.masksToBounds = true
    backgroundColor = UIColor(red: 210 / 255, green: 223 / 255, blue: 255 / 255, alpha: 1)
    addSubview(weatherImageView)
    
    setupConstraints()
  }
  
  private func setupConstraints() {
    let stackView = UIStackView.generateStackView(arrangeSubviews: [tempMaxLabel, tempMinLabel], spacing: 8, axis: .horizontal, distribution: .fill)
    addSubview(stackView)
    
    let weatherImageViewConstraints = [
      weatherImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      weatherImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
      weatherImageView.heightAnchor.constraint(equalToConstant: 50),
      weatherImageView.widthAnchor.constraint(equalToConstant: 50),
    ]
    
    let tempLabelsConstraints = [
      stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24)
    ]
    
    NSLayoutConstraint.activate(weatherImageViewConstraints)
    NSLayoutConstraint.activate(tempLabelsConstraints)
    
    setupWeatherInfoConstraints()
  }
  
  private func setupWeatherInfoConstraints() {
    let stackView = UIStackView.generateStackView(arrangeSubviews: [dayLabel, descriptionLabel], spacing: 4, axis: .vertical, distribution: .fillEqually)
    addSubview(stackView)
    
    let stackViewConstraints = [
      stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      stackView.leadingAnchor.constraint(equalTo: weatherImageView.trailingAnchor, constant: 16),
      stackView.heightAnchor.constraint(equalToConstant: 50)
    ]
    
    NSLayoutConstraint.activate(stackViewConstraints)
  }
}

// MARK: - Configure Cell

extension DailyCollectionViewCell {
  func configureCell(viewModel: [WeatherDailyViewModel], item: Int) {
    let newImage = UIImage.resizeImage(image: UIImage(named: viewModel[item].conditionImage) ?? UIImage(), newWidth: 45)
    self.dayLabel.text = viewModel[item].day
    self.descriptionLabel.text = viewModel[item].description
    self.weatherImageView.image = newImage
    self.tempMaxLabel.text = viewModel[item].tempMax
    self.tempMinLabel.text = viewModel[item].tempMin
  }
}
