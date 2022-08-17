//
//  SearchViewController.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/16/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SearchDisplayLogic: AnyObject {
  func displayData(viewModel: Search.Model.ViewModel.ViewModelData)
}

class SearchViewController: ViewController, SearchDisplayLogic {
  
  private var titles = [String]()
  
  // MARK: - UIComponents
  
  private lazy var searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.placeholder = "Enter city"
    searchBar.translatesAutoresizingMaskIntoConstraints = false
    searchBar.barTintColor = .white
    searchBar.searchTextField.backgroundColor = UIColor.black.withAlphaComponent(0.1)
    searchBar.searchTextField.leftView?.tintColor = .gray
    searchBar.searchTextField.textColor = .black
    return searchBar
  }()
  
  private lazy var tableView: UITableView = {
    let tabelView = UITableView()
    tabelView.separatorStyle = .none
    tabelView.backgroundColor = .white
    tabelView.translatesAutoresizingMaskIntoConstraints = false
    return tabelView
  }()
  
  var interactor: SearchBusinessLogic?
  var router: (NSObjectProtocol & SearchRoutingLogic)?
  
  // MARK: Object lifecycle
  
  init() {
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
    let interactor            = SearchInteractor()
    let presenter             = SearchPresenter()
    let router                = SearchRouter()
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
    
    interactor?.makeRequest(request: .deliveryDelegate)
    view.backgroundColor = .white
    
    setupViews()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    searchBar.becomeFirstResponder()
  }
  
  func displayData(viewModel: Search.Model.ViewModel.ViewModelData) {
    switch viewModel {
    case .displayData(titles: let titles):
      self.titles = titles
      reloadTableView()
    }
  }
  
  private func reloadTableView() {
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
  
  // MARK: - Setup Views
  
  override func setupViews() {
    searchBar.delegate = self
    tableView.delegate = self
    tableView.dataSource = self
    
    tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.reuseId)
    
    view.addSubview(searchBar)
    view.addSubview(tableView)
    
    setupConstraints()
    navigationBarConfigure()
  }
  
  override func setupConstraints() {
    let searchBarConstraints = [
      searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      searchBar.heightAnchor.constraint(equalToConstant: 60),
    ]
    
    let tableViewConstraints = [
      tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ]
    
    NSLayoutConstraint.activate(searchBarConstraints)
    NSLayoutConstraint.activate(tableViewConstraints)
  }
  
  private func navigationBarConfigure() {
    let backButton = UIBarButtonItem()
    backButton.title = "Back"
    self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
  }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return titles.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let backgroundView = UIView()
    backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
    
    let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseId, for: indexPath) as! SearchTableViewCell
    cell.configureWith(titles[indexPath.row])
    cell.selectedBackgroundView = backgroundView
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    interactor?.makeRequest(request: .saveSelectedLocation(indexPath: indexPath, isFavLocation: false))
    router?.popToRootViewController()
  }
  
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let saveAction = UIContextualAction(style: .normal, title: "Save Place") { [weak self] action, view, handler in
      self?.interactor?.makeRequest(request: .saveSelectedLocation(indexPath: indexPath, isFavLocation: true))
      handler(true)
    }
    
    saveAction.backgroundColor = .systemGreen
    
    let configurator = UISwipeActionsConfiguration(actions: [saveAction])
    return configurator
  }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    interactor?.makeRequest(request: .textDidChange(query: searchText))
    self.reloadTableView()
  }
}
