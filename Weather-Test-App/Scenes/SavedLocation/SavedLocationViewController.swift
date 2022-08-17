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

class SavedLocationViewController: ViewController, SavedLocationDisplayLogic {
  
  var interactor: SavedLocationBusinessLogic?
  var router: (NSObjectProtocol & SavedLocationRoutingLogic)?
  private var savedLocation = [SavedLocationViewModel]()
  
  // MARK: - UIComponents
  
  private lazy var tableView: UITableView = {
    let table = UITableView()
    table.translatesAutoresizingMaskIntoConstraints = false
    table.backgroundColor = .white
    table.separatorStyle = .none
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
    
    setupNavigationBar()
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
  
  override func setupViews() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(SavedLocationTableViewCell.self, forCellReuseIdentifier: SavedLocationTableViewCell.reuseId)
    view.backgroundColor = .white
    
    view.addSubview(tableView)
    
    setupConstraints()
  }
  
  override func setupConstraints() {
    let tableViewConstraints = [
      tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
    ]
    
    NSLayoutConstraint.activate(tableViewConstraints)
  }
  
  private func setupNavigationBar() {
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .done, target: self, action: #selector(handleDelete))
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark.circle"), style: .done, target: self, action: #selector(habndleClose))
  }
  
  // MARK: - Navigetion Methods
  
  @objc private func handleDelete() {
    print("delete")
    interactor?.makeRequest(request: .deleteAllData)
    interactor?.makeRequest(request: .retriveSavedLocation)
  }
  
  @objc private func habndleClose() {
    router?.dismiss()
  }
  
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension SavedLocationViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return savedLocation.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let backgroundView = UIView()
    backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
    
    let cell = tableView.dequeueReusableCell(withIdentifier: SavedLocationTableViewCell.reuseId, for: indexPath) as! SavedLocationTableViewCell
    cell.configureWith(savedLocation[indexPath.row])
    cell.selectedBackgroundView = backgroundView
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedItem = savedLocation[indexPath.row]
    interactor?.makeRequest(request: .retriveWeatherByLocation(location: selectedItem))
    router?.dismiss()
  }
  
  func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    return .delete
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let saveLocation = savedLocation[indexPath.row]
      interactor?.makeRequest(request: .deleteLocation(location: saveLocation))
    }
    
    interactor?.makeRequest(request: .retriveSavedLocation)
  }
}
