//
//  WeatherServiceProtocol.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/9/22.
//

import Foundation

protocol WeatherServiceProtocol {
  func fetchCurrentWeather(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherResponse, WeatherServiceError>) -> ())
}
