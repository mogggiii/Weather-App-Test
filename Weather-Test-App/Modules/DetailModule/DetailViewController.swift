//
//  DetailViewController.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/7/22.
//

import UIKit

class DetailViewController: UIViewController {
  
  lazy var headerView = DetailHeaderView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViews()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    headerView.setupGradientBackground()
  }
  
  
  private func setupViews() {
    view.addSubview(headerView)
    
    setupConstraints()
  }
  
  private func setupConstraints() {
    headerView.translatesAutoresizingMaskIntoConstraints = false
    
    let headerViewConstraints = [
      headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      headerView.heightAnchor.constraint(equalToConstant: 300)
    ]
    
    NSLayoutConstraint.activate(headerViewConstraints)
  }
  
}
