//
//  WeatherDailyViewModel.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/12/22.
//

import Foundation

struct WeatherDailyViewModel {
  
  let date: Double
  let day: String
  let tempMin: String
  let tempMax: String
  let description: String
  let conditionImage: String
  
  static func getViewModel(with weatherViewModel: [WeatherViewModel]) -> [WeatherDailyViewModel] {
    var dailyViewModelArray = [WeatherDailyViewModel]()
    
    let temporaryDailyDictionary = Dictionary(grouping: weatherViewModel, by: { $0.dateWithMonth })
    // temporaryDailyDictionary -> ["d/MM": [WeatherViewModel], "d/MM": [WeatherViewModel] ..]
    
    temporaryDailyDictionary.forEach { key, value in
      // find highest temperature using min.
      let tempMax = value.max { $0.tempMaxInt < $1.tempMaxInt }
      // find lowest temperature using min.
      let tempMin = value.min { $0.tempMinInt < $1.tempMinInt }
      guard let tempMax = tempMax, let tempMin = tempMin else { return }
      
      for i in 0...value.count - 1 {
        let date = value[i].date
        let day = value[i].day
        let description = value[i].description
        dailyViewModelArray.append(WeatherDailyViewModel.init(date: date, day: day, tempMin: tempMin.tempMin, tempMax: tempMax.tempMax, description: description, conditionImage: tempMax.conditionImage))
      }
    }
    
    // remove repetitive elements
    let uniqueArray = dailyViewModelArray.unique(for: \.day)
    
    return uniqueArray.sorted { $0.date < $1.date }
  }
}



