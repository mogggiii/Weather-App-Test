//
//  WeatherViewModel.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/12/22.
//

import Foundation

struct WeatherViewModel {
  let date: Double
  let dateWithMonth: String
  let hour: String
  let day: String
  let temp: String
  let tempOriginal: String
  let tempMinInt: Int
  let tempMaxInt: Int
  let tempMin: String
  let tempMax: String
  let feelsLike: String
  let description: String
  let humidity: String
  let pressure: String
  let windSpeed: String
  let visibility: String
  let conditionId: Int
  
  var conditionImage: String {
    switch conditionId {
    case 200...299:
      return "thunderstorms"
    case 300...399:
      return "showers"
    case 500...599:
      return "raining"
    case 600...699:
      return "snowing"
    case 700...799:
      return "windy"
    case 800:
      return "shine"
    default:
      return "cloudy"
    }
  }
  
  static func getViewModels(with weatherResponse: WeatherResponse) -> [WeatherViewModel] {
    return weatherResponse.list.map { getViewModel(eachWeather: $0, response: weatherResponse) }
  }
  
  static func getViewModel(eachWeather: WeatherListResponse, response: WeatherResponse) -> WeatherViewModel {
    let date = eachWeather.dt
    let timeZone = response.city.timezone
    let dateWithMonth = Date.getddMMFormat(timestamp: eachWeather.dtTxt, timeZone: timeZone)
    let hour = Date.getHHFormat(timestamp: eachWeather.dtTxt, timeZone: timeZone)
    let day = Date.getWeekDay(timestamp: eachWeather.dtTxt, timeZone: timeZone)
    let tempOriginal = "\(Int(eachWeather.main.temp))"
    let temp = "\(Int(eachWeather.main.temp))°C"
    let tempMinInt = (Int(eachWeather.main.tempMin))
    let tempMaxInt = (Int(eachWeather.main.tempMax))
    let tempMin = "\(Int(eachWeather.main.tempMin))°C"
    let tempMax = "\(Int(eachWeather.main.tempMax))°C"
    var description: String = ""
    let humidity = "\(eachWeather.main.humidity)%"
    let pressure = "\(Int(eachWeather.main.pressure))hPa"
    let windSpeed = "\(Int(eachWeather.wind.speed * 3.6))km/h"
    let visibility = "\(eachWeather.visibility / 1000)km"
    let feelsLike = "\(Int(eachWeather.main.feelsLike))°C"
    var conditionId: Int = 800
    
    if let weather = eachWeather.weather.first {
      description = weather.description
      conditionId = weather.id
    }
    
    return WeatherViewModel.init(
      date: date,
      dateWithMonth: dateWithMonth,
      hour: hour, day: day,
      temp: temp,
      tempOriginal: tempOriginal,
      tempMinInt: tempMinInt,
      tempMaxInt: tempMaxInt,
      tempMin: tempMin,
      tempMax: tempMax,
      feelsLike: feelsLike,
      description: description,
      humidity: humidity,
      pressure: pressure,
      windSpeed: windSpeed,
      visibility: visibility,
      conditionId: conditionId
    )
  }
}

