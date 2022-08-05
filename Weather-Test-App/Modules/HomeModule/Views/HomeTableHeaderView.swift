//
//  HomeTableHeaderView.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/5/22.
//

import UIKit

class HomeTableHeaderView: UIView {
  
  // MARK: - UIComponents
  
  let containerView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.layer.cornerRadius = 12
    view.layer.masksToBounds = false
    view.layer.shadowColor = UIColor(red: 59 / 255, green: 105 / 255, blue: 222 / 255, alpha: 1).cgColor
    view.layer.shadowOffset = CGSize(width: 0, height: 10)
    view.layer.shadowRadius = 12
    view.layer.shadowOpacity = 0.6
    return view
  }()
  
  let currentDateLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 14, weight: .regular)
    label.textColor = .white
    label.text = "Senin, 20 Desember 2021"
    return label
  }()
  
  let currentTimeLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 14, weight: .regular)
    label.textColor = .white
    label.textAlignment = .right
    label.text = "3.30 PM"
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
    
    addSubview(containerView)
    addSubview(lastUpdateLabel)
    addSubview(weatherImageView)
    containerView.layoutIfNeeded()
    
    setupContainerViewConstraints()
    setupCurrentTimeLabelsConstraints()
    setupLastUpdateLabelConstraints()
    setupWeatherIconConstraints()
    setupCurrentWeatherConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Public Methods
  
  func setupGradientBackground() {
    let backgroundGradient = CAGradientLayer()
    let startColor = UIColor(red: 79 / 255, green: 127 / 255, blue: 250 / 255, alpha: 1)
    let endColor = UIColor(red: 51 / 255, green: 95 / 255, blue: 209 / 255, alpha: 1)
    
    backgroundGradient.frame = containerView.bounds
    backgroundGradient.colors = [startColor.cgColor, endColor.cgColor]
    
    backgroundGradient.startPoint = CGPoint(x: 0.0, y: 1.0)
    backgroundGradient.endPoint = CGPoint(x: 1.0, y: 1.0)
    backgroundGradient.cornerRadius = 12
    
    containerView.layer.insertSublayer(backgroundGradient, at: 0)
  }
  
  // MARK: - Private Methods
  
  private func setupContainerViewConstraints() {
    let containerViewConstraints = [
      containerView.topAnchor.constraint(equalTo: topAnchor, constant: 24),
      containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
    ]
    
    NSLayoutConstraint.activate(containerViewConstraints)
  }
  
  private func setupCurrentTimeLabelsConstraints() {
    let stackView = UIStackView(arrangedSubviews: [currentDateLabel, currentTimeLabel])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.distribution = .fillProportionally
    stackView.axis = .horizontal
    containerView.addSubview(stackView)
    
    let stackViewConstraints = [
      stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 24),
      stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
      stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
    ]
    
    NSLayoutConstraint.activate(stackViewConstraints)
  }
  
  private func setupLastUpdateLabelConstraints() {
    let lastUpdateLabelConstraints = [
      lastUpdateLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -24),
      lastUpdateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
    ]
    
    NSLayoutConstraint.activate(lastUpdateLabelConstraints)
  }
  
  private func setupWeatherIconConstraints() {
    let imageSize = weatherImageView.image?.size
    guard let imageSize = imageSize else { return }
    let aspectRatio = imageSize.width / imageSize.height
    
    let weatherImageViewConstraints = [
      weatherImageView.topAnchor.constraint(equalTo: currentDateLabel.bottomAnchor, constant: 24),
      weatherImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 2),
      weatherImageView.heightAnchor.constraint(equalTo: weatherImageView.widthAnchor, multiplier: 1 / aspectRatio)
    ]
    
    NSLayoutConstraint.activate(weatherImageViewConstraints)
  }
  
  private func setupCurrentWeatherConstraints() {
    
    let stackView = UIStackView(arrangedSubviews: [currentWeatherLabel, currentWeatherTypeLabel])
    stackView.axis = .vertical
    stackView.distribution = .fill
    stackView.spacing = 4
    stackView.translatesAutoresizingMaskIntoConstraints = false
    
    addSubview(stackView)
    
    let stackViewContraints = [
      stackView.topAnchor.constraint(equalTo: currentDateLabel.bottomAnchor, constant: 30),
      stackView.leadingAnchor.constraint(equalTo: weatherImageView.trailingAnchor),
    ]
    
    NSLayoutConstraint.activate(stackViewContraints)
  }
}
