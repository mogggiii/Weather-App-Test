//
//  WeatherRouter.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/12/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol WeatherRoutingLogic {
  func pushToSearchViewController()
  func presentSaveLocationController()
}

class WeatherRouter: NSObject, WeatherRoutingLogic {
  
  weak var viewController: WeatherViewController?
  
  func pushToSearchViewController() {
    print("Search Button Clicked")
    let searchController = SearchViewController()
    viewController?.navigationController?.pushViewController(searchController, animated: true)
  }
  
  func presentSaveLocationController() {
    let navController = NavigationController(rootViewController: SavedLocationViewController())
    navController.modalPresentationStyle = .fullScreen
    viewController?.present(navController, animated: true)
  }
  
}
