//
//  WeatherCardViewController.swift
//  WeCare
//
//  Created by Emilly Maia on 13/02/23.
//

import Foundation
import UIKit

class WeatherCardViewController: UIViewController {
        
    private let cardContainer: WeatherCardView = {
        let weatherCardView = WeatherCardView()
        weatherCardView.translatesAutoresizingMaskIntoConstraints = false
        return weatherCardView
    }()
    
    override func viewDidLoad() {
        view.addSubview(cardContainer)
        view.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            cardContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            cardContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35),
            cardContainer.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
}
