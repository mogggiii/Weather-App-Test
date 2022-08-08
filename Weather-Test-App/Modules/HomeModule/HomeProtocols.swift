//
//  HomeProtocols.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/5/22.
//

import Foundation

protocol HomeConfiguratorProtocol {
  func configure(with viewController: HomeViewController)
}

protocol PresenterToViewMainProtocol {
  func setupUIBindin2()
  func setupUIBinding1()
  func setupUIBinding2()
  func reloadCollectionView()
  func showAlert()
}

protocol PresenterToRouterMainProtocol {
  func pushToDetailViewController()
  func presentSearchViewController()
}
