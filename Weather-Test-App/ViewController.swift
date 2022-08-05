//
//  ViewController.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/5/22.
//

import UIKit

class ViewController: UITableViewController {
  
  let homeCustomNavBar = HomeCustomNavBar()
  let headerView = HomeTableHeaderView()
  
  // MARK: - ViewController Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    
    configureNavigationbar()
    navigationItem.titleView = homeCustomNavBar
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    tableView.tableHeaderView = headerView
    headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 242)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    headerView.setupGradientBackground()
  }
  
  // MARK: - Private Methods
  
  private func configureNavigationbar() {
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "location")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: nil)
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "search")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: nil)
  }
  
  // MARK: - UITableViewDelegate, UITableViewDataSource
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 20
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    return cell
  }
  
  
}

