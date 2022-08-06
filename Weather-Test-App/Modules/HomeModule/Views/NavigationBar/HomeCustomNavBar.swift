//
//  HomeCustomNavBar.swift
//  Weather-Test-App
//
//  Created by Владимир Михайлюк on 8/5/22.
//

import UIKit

class HomeCustomNavBar: UIView {
  
  // MARK: - UIComponents
  
  let slideOutMenuButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(named: "caret_down")?.withRenderingMode(.alwaysOriginal), for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  let locationLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 14, weight: .medium)
    label.text = "Tomsk, Russia"
    label.textColor = .black
    return label
  }()
  
  // MARK: - Init
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Private Methods
  
  private func setupConstraints() {
    let stackView = UIStackView(arrangedSubviews: [locationLabel, slideOutMenuButton])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.spacing = 8
    stackView.axis = .horizontal
    addSubview(stackView)
    
    let stackViewConstraints = [
      stackView.topAnchor.constraint(equalTo: self.topAnchor),
      stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      stackView.heightAnchor.constraint(equalToConstant: 44),
    ]
    
    NSLayoutConstraint.activate(stackViewConstraints)
  }
}
