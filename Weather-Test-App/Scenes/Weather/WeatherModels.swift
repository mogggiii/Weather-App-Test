//
//  WeatherModels.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/12/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum Weather {
  
  enum Model {
    struct Request {
      enum RequestType {
        case retriveCurrentLocationWeather
        case retriveWeather
      }
    }
    
    struct Response {
      enum ResponseType {
        case handleResult(response: WeatherResponse, city: String)
        case handleError(error: Error)
      }
    }
    
    struct ViewModel {
      enum ViewModelData {
        case displayData(viewModel: [WeatherViewModel], cityName: String)
        case displayInfoData(viewModel: WeatherInfoViewModel)
        case displayDailyData(viewModel: [WeatherDailyViewModel])
        case displayError(message: String, animated: Bool)
      }
    }
  }
  
}
