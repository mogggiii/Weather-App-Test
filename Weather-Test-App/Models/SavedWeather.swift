//
//  SavedWeather.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/10/22.
//

import Foundation
import RealmSwift

class SavedWeather: Object {
  @objc dynamic var weatherId: String?
  @objc dynamic var locationName: String?
  @objc dynamic var latitude: Double = 0
  @objc dynamic var longitude: Double = 0
  @objc dynamic var lastUpdateDate: Date?
  @objc dynamic var weatherData: Data?
  
  override class func primaryKey() -> String? {
    return "weatherId"
  }
}
