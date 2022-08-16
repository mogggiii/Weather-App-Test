//
//  AppDelegate.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/5/22.
//

import UIKit
import CoreLocation
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var locationManager: CLLocationManager?
  var realmManager: RealmManager?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    //    setupLocationManager()
    let config = Realm.Configuration(
      schemaVersion: 9, // Set the new schema version.
      migrationBlock: { migration, oldSchemaVersion in
        if oldSchemaVersion < 5 {
          // The enumerateObjects(ofType:_:) method iterates over
          // every Person object stored in the Realm file
          migration.enumerateObjects(ofType: SavedWeather.className()) { oldObject, newObject in
            newObject!["locationName"] = String()
          }
          migration.enumerateObjects(ofType: SavedWeather.className()) { oldObject, newObject in
            newObject!["latitude"] = Double()
          }
          migration.enumerateObjects(ofType: SavedWeather.className()) { oldObject, newObject in
            newObject!["longitude"] = Double()
          }
          migration.enumerateObjects(ofType: SavedWeather.className()) { oldObject, newObject in
            newObject!["lastUpdateDate"] = Date()
          }
        }
      }
    )
    // Tell Realm to use this new configuration object for the default Realm
    Realm.Configuration.defaultConfiguration = config
    // Now that we've told Realm how to handle the schema change, opening the file
    // will automatically perform the migration
    let _ = try! Realm()
    
    return true
  }
  
  // MARK: UISceneSession Lifecycle
  
  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }
  
  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }
}

