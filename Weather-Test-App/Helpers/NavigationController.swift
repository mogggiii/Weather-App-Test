//
//  NavigationController.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/17/22.
//

import Foundation
import UIKit

class NavigationController: UINavigationController {
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    
    if let topVC = viewControllers.last {
      //return the status property of each VC, look at step 2
      return topVC.preferredStatusBarStyle
    }
    
    return .default
  }
}
