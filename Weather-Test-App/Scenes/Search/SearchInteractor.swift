//
//  SearchInteractor.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/16/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import MapKit

protocol SearchBusinessLogic {
  func makeRequest(request: Search.Model.Request.RequestType)
}

class SearchInteractor: NSObject, SearchBusinessLogic {
  
  private var searchResults = [MKLocalSearchCompletion]()
  private var searchCompleter = MKLocalSearchCompleter()
  private let realmManager = RealmManager()
  var presenter: SearchPresentationLogic?
  var service: SearchService?
  
  func makeRequest(request: Search.Model.Request.RequestType) {
    if service == nil {
      service = SearchService()
    }
    
    switch request {
    case .deliveryDelegate:
      searchCompleter.delegate = self
    case .textDidChange(query: let query):
      if query == "" {
        searchResults.removeAll()
      }
      
      searchCompleter.queryFragment = query
      
    case .saveSelectedLocation(indexPath: let indexPath, isFavLocation: let isFavLocation):
      let selectedResult = searchResults[indexPath.row]
      let searchRequest = MKLocalSearch.Request(completion: selectedResult)
      let search = MKLocalSearch(request: searchRequest)
      
      // find the location name, latitude and, longitude
      search.start { [weak self] (response, error) in
        guard error == nil else { return }
        guard let placeMark = response?.mapItems[0].placemark else { return }
        guard let locationName = placeMark.name else { return }
        
        let location = Location()
        location.cityName = locationName
        location.latitude = placeMark.coordinate.latitude
        location.longitude = placeMark.coordinate.longitude
        
        if isFavLocation {
          // Save location
          self?.realmManager.saveLocation(location)
        } else {
          // Delete All local data and Save Only Location Data (No Weather Data)
          self?.realmManager.saveLocationData(location)
        }
      }
    }
  }
  
}

// MARK: - MKLocalSearchCompleterDelegate

extension SearchInteractor: MKLocalSearchCompleterDelegate {
  func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
    // update search results
    searchResults = completer.results
    
    var titlesArray = [String]()
    if searchResults.count >= 0 {
      searchResults.forEach { result in
        titlesArray.append("\(result.title), \(result.subtitle)")
      }
      
      presenter?.presentData(response: .presentTitles(titles: titlesArray))
    }
  }
  
  func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
    print("Cancel")
  }
}
