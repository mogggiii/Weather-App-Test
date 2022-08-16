//
//  HourlyCollectionViewCell.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/6/22.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
  
  /// reuse id
  static let reuseId = "hourlyId"
  
  // MARK: - UIComponenets
  
  private let weatherImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .center
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  private let temperatureLabel: UILabel = {
    let label = UILabel()
    label.text = "20º"
    label.textColor = .black
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 14, weight: .semibold)
    return label
  }()
  
  private let timeLabel: UILabel = {
    let label = UILabel()
    label.text = "4.00 PM"
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 14, weight: .regular)
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
  
  override func prepareForReuse() {
    self.weatherImageView.image = nil
  }
}

// MARK: - Setup Views

extension HourlyCollectionViewCell {
  private func setupViews() {
    layer.cornerRadius = 4
    layer.masksToBounds = true
    backgroundColor = UIColor(red: 251 / 255, green: 251 / 255, blue: 251 / 255, alpha: 1)
    
    setupConstraints()
  }
  
  private func setupConstraints() {
    let stackView = UIStackView.generateStackView(arrangeSubviews: [weatherImageView, temperatureLabel, timeLabel], spacing: nil, axis: .vertical, distribution: .fill)
    stackView.alignment = .center
    addSubview(stackView)
    
    let stackViewConstraint = [
      stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
      stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -19),
      stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 19),
      stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
    ]
    
    NSLayoutConstraint.activate(stackViewConstraint)
    
    setupWeatherIconConstraints()
  }
  
  private func setupWeatherIconConstraints() {
    let imageSize = weatherImageView.image?.size
    guard let imageSize = imageSize else { return }
    let aspectRatio = imageSize.width / imageSize.height
    
    let iconConstraints = [
      weatherImageView.heightAnchor.constraint(equalTo: weatherImageView.widthAnchor, multiplier: 1 / aspectRatio),
    ]
    
    NSLayoutConstraint.activate(iconConstraints)
  }
}

extension HourlyCollectionViewCell {
  func configure(viewModel: [WeatherViewModel], item: Int) {
    let resizebleImage = UIImage.resizeImage(image: UIImage(named: viewModel[item].conditionImage) ?? UIImage(), newWidth: 60)
    timeLabel.text = viewModel[item].hour
    temperatureLabel.text = viewModel[item].temp
    weatherImageView.image = resizebleImage
  }
}
