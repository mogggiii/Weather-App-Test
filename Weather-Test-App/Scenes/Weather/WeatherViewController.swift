//
//  WeatherViewController.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/12/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol WeatherDisplayLogic: AnyObject {
  func displayData(viewModel: Weather.Model.ViewModel.ViewModelData)
}

class WeatherViewController: ViewController, WeatherDisplayLogic {
  
  var interactor: WeatherBusinessLogic?
  var router: (NSObjectProtocol & WeatherRoutingLogic)?
  let realmManager = RealmManager()
  
  init() {
    super.init(nibName: nil, bundle: nil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: - UIComponents
  
  private var alertView: UIAlertController?
  private lazy var headerView = HomeHeaderView()
  private lazy var collectionView: CollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = 0
    let view = CollectionView(frame: .zero, collectionViewLayout: layout)
    return view
  }()
  
  // MARK: Setup
  
  private func setup() {
    let viewController        = self
    let interactor            = WeatherInteractor()
    let presenter             = WeatherPresenter()
    let router                = WeatherRouter()
    viewController.interactor = interactor
    viewController.router     = router
    interactor.presenter      = presenter
    presenter.viewController  = viewController
    router.viewController     = viewController
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    UserDefaults.standard.set(true, forKey: "firstStart")
    
    setupViews()
    configureNavigationBar()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    interactor?.makeRequest(request: .retriveWeather)
    
    headerView.setupGradientBackground()
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .darkContent
  }
  
  func displayData(viewModel: Weather.Model.ViewModel.ViewModelData) {
    switch viewModel {
      
      // hourly and header data
    case .displayData(viewModel: let viewModel, cityName: let cityName):
      DispatchQueue.main.async {
        self.navigationItem.title = cityName
        self.headerView.configureView(viewModel: viewModel, cityName: cityName)
        self.collectionView.hourlyCollectionDidLoad = { hourly in
          hourly.hourlyCollectionView.hourlyCellDidLoad = { cell, indexPath in
            cell.configure(viewModel: viewModel, item: indexPath.item)
          }
          
          hourly.hourlyCollectionView.reloadData()
        }
      }
      
      // Detail Info
    case .displayInfoData(viewModel: let viewModel):
      DispatchQueue.main.async {
        self.collectionView.detailInfoCollectionDidLoad = { detailInfo in
          detailInfo.detailCollectionView.collectionCellDidLoad = { cell, indexPath in
            cell.configureCell(viewModel: viewModel, item: indexPath.item)
          }
          
          detailInfo.detailCollectionView.reloadData()
        }
      }
      
      // Daily Data
    case .displayDailyData(viewModel: let viewModel):
      DispatchQueue.main.async {
        self.collectionView.dailyCollectionDidLoad = { daily in
          daily.dailyCollectionView.dailyCellDidLoad = { cell, indexPath in
            cell.configureCell(viewModel: viewModel, item: indexPath.item)
          }
          
          daily.dailyCollectionView.reloadData()
        }
      }
      
    case .displayError(message: let message, animated: let animated):
      let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
      alertView = alert
      
      present(alert, animated: animated, completion: nil)
    }
    
    reloadCollectionView()
  }
  
  override func setupViews() {
    view.backgroundColor = .white
    view.addSubview(headerView)
    view.addSubview(collectionView)
    setupConstraints()
  }
  
  // MARK: - Private Methods
  
  override func setupConstraints() {
    headerView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    
    let headerViewConstraints = [
      headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
      headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      headerView.heightAnchor.constraint(equalToConstant: 218)
    ]
    
    let collectionViewConstraints = [
      collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 34),
      collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
    ]
    
    NSLayoutConstraint.activate(headerViewConstraints)
    NSLayoutConstraint.activate(collectionViewConstraints)
  }
  
  private func reloadCollectionView() {
    DispatchQueue.main.async {
      self.collectionView.reloadData()
    }
  }
  
  // MARK: - Navigation bar buttons
  
  private func configureNavigationBar() {
    navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "location")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(locationButtonPressed))
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "search")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(searchButtonPressed))
  }
  
  // MARK: - Navigation Actions
  
  @objc private func locationButtonPressed() {
    self.router?.presentSaveLocationController()
  }
  
  @objc private func searchButtonPressed() {
    self.router?.pushToSearchViewController()
  }
}

