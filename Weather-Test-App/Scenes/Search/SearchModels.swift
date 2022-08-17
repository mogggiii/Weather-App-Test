//
//  SearchModels.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/16/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum Search {
  
  enum Model {
    struct Request {
      enum RequestType {
        case deliveryDelegate
        case textDidChange(query: String)
        case saveSelectedLocation(indexPath: IndexPath, isFavLocation: Bool)
      }
    }
    struct Response {
      enum ResponseType {
        case presentTitles(titles: [String])
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case displayData(titles: [String])
      }
    }
  }
  
}
