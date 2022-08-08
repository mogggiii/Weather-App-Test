//
//  DetailViewController.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/7/22.
//

import UIKit

class DetailViewController: UIViewController {
  
  // MARK: - UIComponents
  
  private lazy var headerView = DetailHeaderView()
  private lazy var collectionView: DetailInfoCollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = 0
    let view = DetailInfoCollectionView(frame: .zero, collectionViewLayout: layout)
    return view
  }()
  
  // MARK: - ViewController Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    
    setupViews()
    setupBackgroundGradienInNavBar()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    headerView.setupGradientBackground()
  }
}

// MARK: - Setup Views

extension DetailViewController {
  private func setupViews() {
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
      headerView.heightAnchor.constraint(equalToConstant: 300)
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
}

// MARK: - Background Gradient in nav bar

extension DetailViewController {
  private func setupBackgroundGradienInNavBar() {
    let startColor = UIColor(red: 79 / 255, green: 127 / 255, blue: 250 / 255, alpha: 1)
    let endColor = UIColor(red: 51 / 255, green: 95 / 255, blue: 209 / 255, alpha: 1)
    let navBar = navigationController!.navigationBar
    let rect = CGRect(x: 0, y: -20, width: (self.navigationController?.navigationBar.bounds.width)!, height: (self.navigationController?.navigationBar.bounds.height)! + 20)
    
    let gradientView = genereateGradientView(frame: rect, startColor: startColor, endColor: endColor)
    navBar.insertSubview(gradientView, at: 1)
  }
  
  private func genereateGradientView(frame: CGRect, startColor: UIColor, endColor: UIColor) -> UIView {
    let view = UIView()
    view.frame = frame
    view.backgroundColor = .white
    
    let backgroundGradient = CAGradientLayer()
    backgroundGradient.frame = view.bounds
    backgroundGradient.colors = [startColor.cgColor, endColor.cgColor]
    
    backgroundGradient.startPoint = CGPoint(x: 0.0, y: 1.0)
    backgroundGradient.endPoint = CGPoint(x: 1.0, y: 1.0)
    
    view.layer.insertSublayer(backgroundGradient, at: 0)
    
    return view
  }
}
