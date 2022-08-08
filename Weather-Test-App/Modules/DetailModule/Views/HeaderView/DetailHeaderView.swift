//
//  DetailHeaderView.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/7/22.
//

import UIKit

class DetailHeaderView: UIView {
  // MARK: - UIComponents

  let currentDateAndTimeLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 14, weight: .regular)
    label.textColor = .white
    label.text = "Senin, 20 Desember 2021 - 3.00 PM"
    return label
  }()

  let lastUpdateLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 14, weight: .regular)
    label.textColor = .white
    label.text = "Last Update to 3.00 PM"
    return label
  }()

  let currentWeatherLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 20, weight: .regular)
    label.textColor = .white
    label.text = "18ºC"
    return label
  }()

  let currentWeatherTypeLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 20, weight: .semibold)
    label.textColor = .white
    label.text = "Sunny"
    return label
  }()

  let weatherImageView: UIImageView = {
    let imageView = UIImageView()
    let imageConfig = UIImage.SymbolConfiguration(pointSize: 61)
    imageView.contentMode = .scaleAspectFit
    imageView.image = UIImage(named: "Group 21")?.withConfiguration(imageConfig)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  // MARK: - Init

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupViews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Public Methods

  func setupGradientBackground() {
    let backgroundGradient = CAGradientLayer()
    let startColor = UIColor(red: 79 / 255, green: 127 / 255, blue: 250 / 255, alpha: 1)
    let endColor = UIColor(red: 51 / 255, green: 95 / 255, blue: 209 / 255, alpha: 1)

    backgroundGradient.frame = self.bounds
    backgroundGradient.colors = [startColor.cgColor, endColor.cgColor]

    backgroundGradient.startPoint = CGPoint(x: 0.0, y: 1.0)
    backgroundGradient.endPoint = CGPoint(x: 1.0, y: 1.0)

    layer.insertSublayer(backgroundGradient, at: 0)
  }

  // MARK: - Private Methods

  private func setupViews() {
    addSubview(currentDateAndTimeLabel)
    addSubview(lastUpdateLabel)
    addSubview(weatherImageView)
    
    setupCurrentTimeLabelsConstraints()
  }

  private func setupCurrentTimeLabelsConstraints() {
    let currentTimeConstraints = [
      currentDateAndTimeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 24),
      currentDateAndTimeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
    ]

    NSLayoutConstraint.activate(currentTimeConstraints)
    
    setupLastUpdateLabelConstraints()
  }

  private func setupLastUpdateLabelConstraints() {
    let lastUpdateLabelConstraints = [
      lastUpdateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24),
      lastUpdateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
    ]

    NSLayoutConstraint.activate(lastUpdateLabelConstraints)
    
    setupWeatherIconConstraints()
  }

  private func setupWeatherIconConstraints() {
    let imageSize = weatherImageView.image?.size
    guard let imageSize = imageSize else { return }
    let aspectRatio = imageSize.width / imageSize.height

    let weatherImageViewConstraints = [
      weatherImageView.topAnchor.constraint(equalTo: currentDateAndTimeLabel.bottomAnchor, constant: 24),
      weatherImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      weatherImageView.heightAnchor.constraint(equalTo: weatherImageView.widthAnchor, multiplier: 1 / aspectRatio)
    ]

    NSLayoutConstraint.activate(weatherImageViewConstraints)
    
    setupCurrentWeatherConstraints()
  }

  private func setupCurrentWeatherConstraints() {
    let stackView = UIStackView(arrangedSubviews: [currentWeatherLabel, currentWeatherTypeLabel])
    stackView.axis = .vertical
    stackView.distribution = .fill
    stackView.alignment = .center
    stackView.spacing = 4
    stackView.translatesAutoresizingMaskIntoConstraints = false

    addSubview(stackView)

    let stackViewContraints = [
      stackView.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor, constant: 16),
      stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
    ]

    NSLayoutConstraint.activate(stackViewContraints)
  }
}
