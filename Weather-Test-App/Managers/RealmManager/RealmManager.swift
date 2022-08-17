//
//  RealmManager.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/10/22.
//

import Foundation
import RealmSwift

class RealmManager: NSObject {
  
  // MARK: - Location List
  
  func fetchSavedLocationList() -> Results<Location> {
    let realmObject = try! Realm()
    
    return realmObject.objects(Location.self)
  }
  
  // MARK: - Saved location weather
  
  func fetchSavedWeather() -> SavedWeather? {
    let realmObject = try! Realm()
    guard let savedWeather = realmObject.objects(SavedWeather.self).first else { return nil }
    return savedWeather
  }
  
  func fetchWeatherResponse() -> WeatherResponse? {
    let realmObject = try! Realm()
    guard let savedWeather = realmObject.objects(SavedWeather.self).first,
          let weatherResponse = savedWeather.weatherData
    else { return nil }
    
    return self.decode(weatherResponse)
  }
  
  func deleteLocalWeatherData() {
    let realmObject = try! Realm()
    let localWeather = realmObject.objects(SavedWeather.self)
    try! realmObject.write {
      realmObject.delete(localWeather)
    }
  }
  
  func saveLocalWeatherData(weather: WeatherResponse, location: Location) {
    deleteLocalWeatherData()
    
    let localWeatherModel = SavedWeather()
    localWeatherModel.weatherId = UUID().uuidString
    localWeatherModel.locationName = location.cityName
    localWeatherModel.longitude = location.longitude
    localWeatherModel.latitude = location.latitude
    localWeatherModel.lastUpdateDate = Date()
    localWeatherModel.weatherData = self.encode(weather)
    
    self.save(localWeatherModel)
  }
  
  func deleteFavLocation(location: Location) {
    let realmObject = try! Realm()
    let locationData = realmObject.objects(Location.self)
    
    try! realmObject.write {
      realmObject.delete(locationData.filter("cityName=%@", location.cityName!))
    }
  }
  
  func saveLocationData(_ location: Location) {
    deleteLocalWeatherData()
    
    let locationModel = SavedWeather()
    locationModel.latitude = location.latitude
    locationModel.longitude = location.longitude
    locationModel.locationName = location.cityName
    self.save(locationModel)
  }
  
  func saveLocation(_ location: Location) {
    self.save(location)
  }
  
  func deleteAllData() {
    let realmObject = try! Realm()
    let locations = realmObject.objects(Location.self)
    
    try! realmObject.write {
      realmObject.delete(locations)
    }
  }
  
  func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentsDirectory = paths[0]
    return documentsDirectory
  }
}

extension RealmManager {
  private func save(_ object: Object) {
    let realmObject = try! Realm()
    
    try! realmObject.write {
      realmObject.add(object)
    }
  }
  
  private func decode(_ data: Data) -> WeatherResponse? {
    do {
      let decodedWeather = try JSONDecoder().decode(WeatherResponse.self, from: data)
      return decodedWeather
    } catch {
      print("Realm Decoded Error")
    }
    
    return nil
  }
  
  private func encode(_ response: WeatherResponse) -> Data? {
    do {
      let encodedData = try JSONEncoder().encode(response)
      return encodedData
    } catch {
      print("Realm Encoded Error")
    }
    
    return nil
  }
}

