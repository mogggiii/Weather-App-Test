//
//  SavedLocationModels.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/16/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import RealmSwift

enum SavedLocation {
   
  enum Model {
    struct Request {
      enum RequestType {
        case retriveSavedLocation
        case retriveWeatherByLocation(location: SavedLocationViewModel)
      }
    }
    struct Response {
      enum ResponseType {
        case handleResult(results: Results<Location>)
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case presentSavedLocation(viewModel: [SavedLocationViewModel])
      }
    }
  }
  
}

struct SavedLocationViewModel {
  let cityName: String
  let latitude: Double
  let longitude: Double
}
