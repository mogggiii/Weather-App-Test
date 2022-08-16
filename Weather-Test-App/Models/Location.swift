//
//  Location.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/16/22.
//

import Foundation
import RealmSwift

class Location: Object {
  @objc dynamic var cityName: String?
  @objc dynamic var latitude: Double = 0
  @objc dynamic var longitude: Double = 0
}

