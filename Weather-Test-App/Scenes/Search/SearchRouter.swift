//
//  SearchRouter.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/16/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SearchRoutingLogic {
  func popToRootViewController()
}

class SearchRouter: NSObject, SearchRoutingLogic {
  weak var viewController: SearchViewController?
  
  // MARK: Routing
  
  func popToRootViewController() {
    viewController?.navigationController?.popToRootViewController(animated: true)
  }
}
