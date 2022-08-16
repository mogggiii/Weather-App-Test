//
//  HomeTableHeaderView.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/5/22.
//

import UIKit

class HomeHeaderView: UIView {
  
  var currentWeatherCardTap: (() -> ())?
  
  // MARK: - UIComponents
  
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
  
  let feelsLikeLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 18, weight: .regular)
    label.textColor = .white
    label.text = "Last Update to 3.00 PM"
    return label
  }()
  
  let currentTempLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 20, weight: .regular)
    label.textColor = .white
    label.text = "18ºC"
    return label
  }()
  
  let weatherDescriptionLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 20, weight: .semibold)
    label.textColor = .white
    label.text = "Sunny"
    return label
  }()
  
  let weatherImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .center
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
    backgroundGradient.cornerRadius = 12
    
    self.layer.insertSublayer(backgroundGradient, at: 0)
  }
  
  @objc private func currentWeatherCardDidTap() {
    if let currentWeatherCardTap = currentWeatherCardTap {
      currentWeatherCardTap()
    }
  }
}

// MARK: - Setup Views

extension HomeHeaderView {
  private func setupViews() {
    self.layer.cornerRadius = 12
    self.layer.masksToBounds = false
    self.layer.shadowColor = UIColor(red: 59 / 255, green: 105 / 255, blue: 222 / 255, alpha: 1).cgColor
    self.layer.shadowOffset = CGSize(width: 0, height: 10)
    self.layer.shadowRadius = 12
    self.layer.shadowOpacity = 0.4
    
    self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(currentWeatherCardDidTap)))
    
    addSubview(feelsLikeLabel)
    addSubview(weatherImageView)
    
//    setupWeatherIconConstraints()
    setupCurrentTimeLabelsConstraints()
  }
  
  private func setupCurrentTimeLabelsConstraints() {
    let stackView = UIStackView.generateStackView(arrangeSubviews: [currentDateLabel, currentTimeLabel], spacing: nil, axis: .horizontal, distribution: .fillProportionally)
    addSubview(stackView)
    
    let stackViewConstraints = [
      stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 24),
      stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
      stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
    ]
    
    NSLayoutConstraint.activate(stackViewConstraints)
    
    setupFeelsLikeLabelConstraints()
  }
  
  private func setupFeelsLikeLabelConstraints() {
    let feelsLikeLabelConstraints = [
      feelsLikeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24),
      feelsLikeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
    ]
    
    NSLayoutConstraint.activate(feelsLikeLabelConstraints)
  }
  
  private func setupWeatherIconConstraints() {
    let weatherImageViewConstraints = [
      weatherImageView.topAnchor.constraint(equalTo: currentDateLabel.bottomAnchor, constant: 24),
      weatherImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
      weatherImageView.heightAnchor.constraint(equalToConstant: 64),
      weatherImageView.widthAnchor.constraint(equalToConstant: 64),
    ]
    
    NSLayoutConstraint.activate(weatherImageViewConstraints)
    setupCurrentWeatherConstraints()
  }
  
  private func setupCurrentWeatherConstraints() {
    let stackView = UIStackView.generateStackView(arrangeSubviews: [currentTempLabel, weatherDescriptionLabel], spacing: 6, axis: .vertical, distribution: .fill)
    addSubview(stackView)
    
    let stackViewContraints = [
      stackView.topAnchor.constraint(equalTo: currentDateLabel.bottomAnchor, constant: 30),
      stackView.leadingAnchor.constraint(equalTo: weatherImageView.trailingAnchor, constant: 24),
    ]
    
    NSLayoutConstraint.activate(stackViewContraints)
  }
}

extension HomeHeaderView {
  func configureView(viewModel: [WeatherViewModel], cityName: String) {
    guard let recentData = viewModel.first else { return }
    let resizebleImage = UIImage.resizeImage(image: UIImage(named: recentData.conditionImage) ?? UIImage(), newWidth: 100)
    currentTempLabel.text = recentData.temp
    currentDateLabel.text = "\(recentData.day), \(recentData.dateWithMonth)"
    weatherDescriptionLabel.text = recentData.description
    weatherImageView.image = resizebleImage
    feelsLikeLabel.text = "Feels like \(recentData.feelsLike)"
    
    setupWeatherIconConstraints()
  }
}
