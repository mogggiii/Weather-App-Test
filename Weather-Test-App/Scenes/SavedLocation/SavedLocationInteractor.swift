//
//  SavedLocationInteractor.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/16/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SavedLocationBusinessLogic {
  func makeRequest(request: SavedLocation.Model.Request.RequestType)
}

class SavedLocationInteractor: SavedLocationBusinessLogic {

  var presenter: SavedLocationPresentationLogic?
  var service: SavedLocationService?
  private let realmManager = RealmManager()
  
  func makeRequest(request: SavedLocation.Model.Request.RequestType) {
    if service == nil {
      service = SavedLocationService()
    }
    
    switch request {
    case .retriveSavedLocation:
      let savedLocation = realmManager.fetchSavedLocationList()
      presenter?.presentData(response: .handleResult(results: savedLocation))
    case .retriveWeatherByLocation(location: let location):
      let locationData = Location()
      locationData.cityName = location.cityName
      locationData.latitude = location.latitude
      locationData.longitude = location.longitude
      
      self.realmManager.saveLocationData(locationData)
    }
  
  }
  
}
