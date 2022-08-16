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

class SearchViewController: UIViewController, SearchDisplayLogic {
  
  private var titles = [String]()
  
  // MARK: - UIComponents
  
  private lazy var searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.placeholder = "Enter city"
    searchBar.translatesAutoresizingMaskIntoConstraints = false
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
  
  private func setupViews() {
    searchBar.delegate = self
    tableView.delegate = self
    tableView.dataSource = self
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "searchCell")
    
    view.addSubview(searchBar)
    view.addSubview(tableView)
    
    setupConstraints()
  }
  
  private func setupConstraints() {
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
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return titles.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
    cell.textLabel?.text = titles[indexPath.row]
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    interactor?.makeRequest(request: .saveSelectedLocation(indexPath: indexPath))
    router?.popToRootViewController()
  }
}

extension SearchViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    interactor?.makeRequest(request: .textDidChange(query: searchText))
    self.reloadTableView()
  }
}
