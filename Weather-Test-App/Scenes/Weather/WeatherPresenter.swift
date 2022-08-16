//
//  WeatherPresenter.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/12/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol WeatherPresentationLogic {
  func presentData(response: Weather.Model.Response.ResponseType)
}

class WeatherPresenter: WeatherPresentationLogic {
  weak var viewController: WeatherDisplayLogic?
  
  func presentData(response: Weather.Model.Response.ResponseType) {
    switch response {
    case .handleResult(response: let response, city: let city):
      let weatherViewModel = WeatherViewModel.getViewModels(with: response)
      let weatherInfoViewModel = WeatherInfoViewModel.getViewModel(with: weatherViewModel)
      let weatherDailyModel = WeatherDailyViewModel.getViewModel(with: weatherViewModel)
      viewController?.displayData(viewModel: .displayData(viewModel: weatherViewModel, cityName: city))
      viewController?.displayData(viewModel: .displayInfoData(viewModel: weatherInfoViewModel))
      viewController?.displayData(viewModel: .displayDailyData(viewModel: weatherDailyModel))
    case .handleError(error: let error):
      viewController?.displayData(viewModel: .displayError(message: error.localizedDescription, animated: true))
    }
  }
  
}
