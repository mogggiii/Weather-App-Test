//
//  WeatherInfoViewModel.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/12/22.
//

import Foundation

struct WeatherInfoViewModel {
  
  let infos: [String]
  
  init(infos: [String]) {
    self.infos = infos
  }
  
  static func getViewModel(with weatherViewModel: [WeatherViewModel]) -> WeatherInfoViewModel {
    var infos = [String]()
    if let recentWeather = weatherViewModel.first {
      infos.append(recentWeather.humidity)
      infos.append(recentWeather.pressure)
      infos.append(recentWeather.windSpeed)
      infos.append(recentWeather.visibility)
    }
    //infos -> [[humidity, pressure, windSpeed, visibility], [..], [..] ..]
    return WeatherInfoViewModel(infos: infos)
  }
}
