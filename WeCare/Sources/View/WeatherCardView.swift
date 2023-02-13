//
//  WeatherCardView.swift
//  WeCare
//
//  Created by Emilly Maia on 10/02/23.
//

import Foundation
import UIKit

class WeatherCardView: UIView {
    
    lazy var weatherCard: UIView = {
        let card = UIView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.backgroundColor = .systemGray
        card.layer.shadowColor = UIColor.black.cgColor
        card.layer.shadowOffset = CGSizeMake(2.5, 2.5)
        card.layer.shadowRadius = 0.9
        card.layer.shadowOpacity = 0.2
        card.layer.cornerCurve = .circular
        card.layer.cornerRadius = 20
        return card
    }()
    
    private lazy var weatherIcon: UIImageView =  {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit
        icon.image = UIImage(named: "sun.max.fill")
        return icon
    }()
    
    private lazy var temperature: UILabel = {
        let temperature = UILabel()
        temperature.translatesAutoresizingMaskIntoConstraints = false
        temperature.text = "29°C"
        return temperature
    }()
    
    private lazy var location: UILabel = {
        let location = UILabel()
        location.translatesAutoresizingMaskIntoConstraints = false
        return location
    }()
    
    private lazy var uvIndex: UILabel = {
        let uvIndex = UILabel()
        uvIndex.translatesAutoresizingMaskIntoConstraints = false
        return uvIndex
    }()
    
    init() {
        super.init(frame: .zero)
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension WeatherCardView: ViewCoding {
    func setupView() {
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            weatherCard.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.55),
            weatherCard.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            weatherCard.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            weatherCard.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            weatherCard.trailingAnchor.constraint(equalTo: weatherCard.trailingAnchor, constant: -15),
            weatherCard.topAnchor.constraint(equalTo: weatherCard.topAnchor, constant: 15)
            
        ])
    }
    
    func setupHierarchy() {
        addSubview(weatherCard)
        weatherCard.addSubview(weatherIcon)
        weatherCard.addSubview(temperature)
        weatherCard.addSubview(uvIndex)
        weatherCard.addSubview(location)
    }
    
    
}


