//
//  StartViewController.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/10/22.
//

import CoreLocation
import UIKit

class StartViewController: UIViewController {
  
  private let locationManager = CLLocationManager()
  private let realmManager = RealmManager()
  
  // MARK: - UIComponents
  
  private let greetingLabel: UILabel = {
    let label = UILabel()
    label.text = "Hello!"
    label.font = .systemFont(ofSize: 25, weight: .bold)
    label.textColor = .black
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.text = "Приложение предоставляет точный прогноз и погодные предупреждения где бы вы ни были. Пожалуйста, дайте разрешение на использование Службы геолокации."
    label.font = .systemFont(ofSize: 17, weight: .regular)
    label.textColor = .black
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let continueButton: UIButton = {
    let button = UIButton()
    button.setTitle("Continue", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViews()
    currentLocation()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    setupGradientBackground()
  }
  
  private func setupViews() {
    view.addSubview(continueButton)
    view.addSubview(descriptionLabel)
    view.addSubview(greetingLabel)
    
    setupConstraints()
  }
  
  @objc private func continueButtonTapped() {
    let homeController = WeatherViewController()
    navigationController?.pushViewController(homeController, animated: true)
    navigationController?.viewControllers = [homeController]
  }
  
  private func setupConstraints() {
    let buttonConstraints = [
      continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
      continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
      continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
      continueButton.heightAnchor.constraint(equalToConstant: 40),
    ]
    
    let greetingLabelConstraints = [
      greetingLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -16),
      greetingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      greetingLabel.widthAnchor.constraint(equalToConstant: 100),
    ]
    
    let descriptionLabelConstraints = [
      descriptionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
    ]
    
    NSLayoutConstraint.activate(buttonConstraints)
    NSLayoutConstraint.activate(descriptionLabelConstraints)
    NSLayoutConstraint.activate(greetingLabelConstraints)
  }
  
  private func setupGradientBackground() {
    let backgroundGradient = CAGradientLayer()
    let startColor = UIColor(red: 79 / 255, green: 127 / 255, blue: 250 / 255, alpha: 1)
    let endColor = UIColor(red: 51 / 255, green: 95 / 255, blue: 209 / 255, alpha: 1)

    backgroundGradient.frame = view.bounds
    backgroundGradient.colors = [startColor.cgColor, endColor.cgColor]

    backgroundGradient.startPoint = CGPoint(x: 0.0, y: 1.0)
    backgroundGradient.endPoint = CGPoint(x: 1.0, y: 1.0)

    view.layer.insertSublayer(backgroundGradient, at: 0)
  }
  
  private func currentLocation() {
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
  }
}

extension StartViewController: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.last else { return }
    manager.stopUpdatingLocation()
    self.geocodeLocation(location)
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("error")
  }
  
  private func geocodeLocation(_ location: CLLocation) {
    CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
      if error == nil && placemarks!.count > 0 {
        guard let placemark = placemarks?.last else {
          return
        }
        let city = placemark.locality ?? ""
//        let locationData = Location()
//        locationData.cityName = city
//        locationData.latitude = location.coordinate.latitude
//        locationData.longitude = location.coordinate.longitude
//
//        self.realmManager.saveCurrentLocation(locationData)
        let locationData = Location()
        locationData.cityName = city
        locationData.latitude = location.coordinate.latitude
        locationData.longitude = location.coordinate.longitude
        
        self.realmManager.saveLocationData(locationData)
      }
    }
  }
}
