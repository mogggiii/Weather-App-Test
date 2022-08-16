//
//  String+Extension.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/16/22.
//

import Foundation

extension String {
  func capitalizingFirstLetter() -> String {
    return prefix(1).capitalized + dropFirst()
  }
  
  mutating func capitalizeFirstLetter() {
    self = self.capitalizingFirstLetter()
  }
}
