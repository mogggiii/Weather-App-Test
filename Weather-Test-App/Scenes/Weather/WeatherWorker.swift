//
//  WeatherWorker.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/12/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class WeatherService: WeatherServiceProtocol {  
  func fetchCurrentWeather(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherResponse, WeatherServiceError>) -> ()) {
    var urlComponents = URLComponents(string: OpenWeatherAPI.baseUrl)
    urlComponents?.queryItems = [
      URLQueryItem(name: "APPID", value: OpenWeatherAPI.apiKey),
      URLQueryItem(name: "lat", value: "\(latitude)"),
      URLQueryItem(name: "lon", value: "\(longitude)"),
      URLQueryItem(name: "units", value: "metric")
    ]
    
    guard let url = urlComponents?.url else { return }
    self.handleRequest(url: url, completion: completion)
  }
  
  private func handleRequest(url: URL, completion: @escaping (Result<WeatherResponse, WeatherServiceError>) -> ()) {
    URLSession.shared.dataTask(with: url) { data, response, error in
      guard error == nil else {
        completion(.failure(.clientError))
        return
      }
      
      guard let data = data else {
        completion(.failure(.noData))
        return
      }
      
      do {
        let result = try JSONDecoder().decode(WeatherResponse.self, from: data)
        completion(.success(result))
      } catch {
        completion(.failure(.decodeError))
      }
    } .resume()
  }
  
}

