//
//  SavedLocationRouter.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/16/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SavedLocationRoutingLogic {
  func dismiss()
}

class SavedLocationRouter: NSObject, SavedLocationRoutingLogic {

  weak var viewController: SavedLocationViewController?
  
  // MARK: Routing
  func dismiss() {
    viewController?.dismiss(animated: true)
  }
}
