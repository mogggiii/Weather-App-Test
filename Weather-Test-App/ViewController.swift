//
//  ViewController.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/5/22.
//

import UIKit

class ViewController: UIViewController {
  
  private lazy var homeCustomNavBar = HomeCustomNavBar()
  let headerView = HomeTableHeaderView()
  private lazy var collectionView: CollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = 0
    let view = CollectionView(frame: .zero, collectionViewLayout: layout)
    return view
  }()
  
  // MARK: - ViewController Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureNavigationbar()
    setupViews()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    headerView.setupGradientBackground()
  }
  
  
  // MARK: - Private Methods
  
  private func setupViews() {
    view.backgroundColor = .white
    view.addSubview(headerView)
    view.addSubview(collectionView)
    setupConstraints()
  }
  
  private func setupConstraints() {
    headerView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    
    let headerViewConstraints = [
      headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      headerView.heightAnchor.constraint(equalToConstant: 242)
    ]
    
    let collectionViewConstraints = [
      collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10),
      collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
    ]
  
    NSLayoutConstraint.activate(headerViewConstraints)
    NSLayoutConstraint.activate(collectionViewConstraints)
  }
  
  private func configureNavigationbar() {
    navigationItem.titleView = homeCustomNavBar
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "location")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: nil)
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "search")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: nil)
  }
  
}

