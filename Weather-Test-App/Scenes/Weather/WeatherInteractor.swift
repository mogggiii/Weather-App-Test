//
//  WeatherInteractor.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/12/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol WeatherBusinessLogic {
  func makeRequest(request: Weather.Model.Request.RequestType)
}

class WeatherInteractor: WeatherBusinessLogic {
  
  var presenter: WeatherPresentationLogic?
  var service: WeatherService?
  private let realmManager = RealmManager()
  private var localData: SavedWeather?
  private var currentLocation: Location?
  
  func makeRequest(request: Weather.Model.Request.RequestType) {
    if service == nil {
      service = WeatherService()
    }
    switch request {
    case .retriveCurrentLocationWeather:
//      currentLocationWeather()
      print(1)
    case .retriveWeather:
      fetchWeather()
    }
  }
  
  private func fetchWeather() {
    localData = realmManager.fetchSavedWeather()
    
    guard let city = localData?.locationName,
          let latitude = localData?.latitude,
          let longitude = localData?.longitude
    else { return }
    
    let location = Location()
    location.cityName = city
    location.latitude = latitude
    location.longitude = longitude
    
    guard let _ = localData?.weatherData,
          let weatherResponse = realmManager.fetchWeatherResponse()
    else {
      fetchWeatherData(by: location)
      return
    }
    
    if let lastUpdateDate = localData?.lastUpdateDate {
      self.fetchedAPI180MinutesAgo(from: lastUpdateDate) ? fetchWeatherData(by: location) : presenter?.presentData(response: .handleResult(response: weatherResponse, city: location.cityName ?? ""))
    }
  }
  
  private func fetchedAPI180MinutesAgo(from lastRefreshDate: Date) -> Bool {
    let currentDate = Date()
    return currentDate.minutes(from: lastRefreshDate) >= 180 ? true : false
  }
  
  private func fetchWeatherData(by location: Location) {
    service?.fetchCurrentWeather(latitude: location.latitude, longitude: location.longitude) { result in
      switch result {
      case .success(let response):
        self.realmManager.saveLocalWeatherData(weather: response, location: location)
        guard let data = self.realmManager.fetchWeatherResponse() else { return }
        self.presenter?.presentData(response: .handleResult(response: data, city: location.cityName ?? ""))
      case .failure(let error):
        self.presenter?.presentData(response: .handleError(error: error))
      }
    }
  }
}
