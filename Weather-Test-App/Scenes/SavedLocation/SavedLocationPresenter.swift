//
//  SavedLocationPresenter.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/16/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SavedLocationPresentationLogic {
  func presentData(response: SavedLocation.Model.Response.ResponseType)
}

class SavedLocationPresenter: SavedLocationPresentationLogic {
  weak var viewController: SavedLocationDisplayLogic?
  
  func presentData(response: SavedLocation.Model.Response.ResponseType) {
    switch response {
    case .handleResult(results: let results):
      var savedLocation = [SavedLocationViewModel]()
      results.forEach { location in
        savedLocation.append(SavedLocationViewModel(cityName: location.cityName ?? "", latitude: location.latitude, longitude: location.longitude))
      }
      
      viewController?.displayData(viewModel: .presentSavedLocation(viewModel: savedLocation))
    }
  }
  
}
