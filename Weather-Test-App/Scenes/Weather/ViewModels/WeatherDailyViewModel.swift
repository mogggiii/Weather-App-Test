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
  let conditionImage: String
  
  init(tempMin: String, tempMax: String, conditionImage: String, day: String, date: Double) {
    self.date = date
    self.day = day
    self.tempMin = tempMin
    self.tempMax = tempMax
    self.conditionImage = conditionImage
  }
  
  static func getViewModel(with weatherViewModel: [WeatherViewModel]) -> [WeatherDailyViewModel] {
    var dailyViewModelArray = [WeatherDailyViewModel]()
  
    let temporaryDailyDictionary = Dictionary(grouping: weatherViewModel, by: { $0.dateWithMonth })
    // temporaryDailyDictionary -> ["17/08": [WeatherViewModel], 18/08: [WeatherViewModel] ..]
    
    temporaryDailyDictionary.forEach { key, value in
      let tempMax = value.max { $0.tempMaxInt < $1.tempMaxInt }
      // find lowest temperature using min.
      let tempMin = value.min { $0.tempMinInt < $1.tempMinInt }
      guard let tempMax = tempMax, let tempMin = tempMin else { return }
      
      for i in 0...value.count - 1 {
        let date = value[i].date
        let day = value[i].day
        dailyViewModelArray.append(WeatherDailyViewModel.init(tempMin: tempMin.tempMin, tempMax: tempMax.tempMax, conditionImage: tempMax.conditionImage, day: day, date: date))
      }
    }
    
    let uniqueArray = dailyViewModelArray.unique(for: \.day)
    
    return uniqueArray.sorted { $0.date < $1.date }
  }
}

  

