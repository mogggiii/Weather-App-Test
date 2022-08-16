//
//  SavedLocationViewController.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/16/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SavedLocationDisplayLogic: AnyObject {
  func displayData(viewModel: SavedLocation.Model.ViewModel.ViewModelData)
}

class SavedLocationViewController: UIViewController, SavedLocationDisplayLogic {

  var interactor: SavedLocationBusinessLogic?
  var router: (NSObjectProtocol & SavedLocationRoutingLogic)?
  private var savedLocation = [SavedLocationViewModel]()
  
  // MARK: - UIComponents
  
  private lazy var tableView: UITableView = {
    let table = UITableView()
    table.translatesAutoresizingMaskIntoConstraints = false
    table.backgroundColor = .white
    return table
  }()

  // MARK: Object lifecycle
  
  init () {
    super.init(nibName: nil, bundle: nil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup() {
    let viewController        = self
    let interactor            = SavedLocationInteractor()
    let presenter             = SavedLocationPresenter()
    let router                = SavedLocationRouter()
    viewController.interactor = interactor
    viewController.router     = router
    interactor.presenter      = presenter
    presenter.viewController  = viewController
    router.viewController     = viewController
  }
  
  // MARK: Routing
  

  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViews()
    interactor?.makeRequest(request: .retriveSavedLocation)
  }
  
  func displayData(viewModel: SavedLocation.Model.ViewModel.ViewModelData) {
    switch viewModel {
    case .presentSavedLocation(viewModel: let viewModel):
      self.savedLocation = viewModel
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  
  // MARK: - Setup Views
  
  private func setupViews() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "savedLocationCell")
    view.backgroundColor = .white
    
    view.addSubview(tableView)
    
    setupConstraints()
  }
  
  private func setupConstraints() {
    let tableViewConstraints = [
      tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
    ]
    
    NSLayoutConstraint.activate(tableViewConstraints)
  }
  
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension SavedLocationViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return savedLocation.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "savedLocationCell", for: indexPath)
    cell.textLabel?.text = savedLocation[indexPath.row].cityName
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedItem = savedLocation[indexPath.row]
    interactor?.makeRequest(request: .retriveWeatherByLocation(location: selectedItem))
    router?.dismiss()
  }
}
