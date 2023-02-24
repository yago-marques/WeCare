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
        card.backgroundColor = UIColor(red: 0.40, green: 0.84, blue: 0.80, alpha: 0.8)
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
        icon.tintColor = UIColor(red: 0.99, green: 0.97, blue: 1, alpha: 1)
        return icon
    }()
    
    private lazy var temperature: UILabel = {
        let temperature = UILabel()
        temperature.translatesAutoresizingMaskIntoConstraints = false
        temperature.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        return temperature
    }()
    
    private lazy var location: UILabel = {
        let location = UILabel()
        location.translatesAutoresizingMaskIntoConstraints = false
        location.adjustsFontForContentSizeCategory = true
        location.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return location
    }()
    
    private lazy var uvIndex: UILabel = {
        let uvIndex = UILabel()
        uvIndex.translatesAutoresizingMaskIntoConstraints = false
        uvIndex.adjustsFontForContentSizeCategory = true
        uvIndex.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return uvIndex
    }()
    
    init() {
        super.init(frame: .zero)
        buildLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    func setup(viewModel: WeatherCardViewModel?) {
        guard let viewModel else { return }
        weatherIcon.image = UIImage(named: viewModel.weather.weatherIcon)
//        weatherIcon.accessibilityLabel = "Sol azul"
        temperature.text = viewModel.weather.temperature
        location.text = "\(viewModel.weather.city), \(viewModel.weather.country)"
        uvIndex.text = "Índice UV: \(viewModel.weather.uvIndex)"
        groupAccessible()
    }

    func groupAccessible() {
        self.weatherCard.isAccessibilityElement = false
//        self.weatherIcon.isAccessibilityElement = false
        self.location.isAccessibilityElement = false
        self.temperature.isAccessibilityElement = false
        self.uvIndex.isAccessibilityElement = false

        self.shouldGroupAccessibilityChildren = true
        self.isAccessibilityElement = true

//        let weatherIconAccessible = weatherIcon.accessibilityLabel ?? "nao deu"
        let locationAccessible = location.text ?? "erro"
        let temperatureAccessible = temperature.text ?? "erro"
        let uvIndexAccessible = uvIndex.text ?? "erro"

        self.accessibilityLabel = """
            temperatura \(temperatureAccessible) em \(locationAccessible), com \(uvIndexAccessible)
        """
    }

}

extension WeatherCardView: ViewCoding {
    func setupView() { }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            weatherCard.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            weatherCard.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            weatherCard.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            weatherCard.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            temperature.leadingAnchor.constraint(equalToSystemSpacingAfter: weatherCard.leadingAnchor, multiplier: 3),
            temperature.topAnchor.constraint(equalToSystemSpacingBelow: weatherCard.topAnchor, multiplier: 3),

            location.leadingAnchor.constraint(equalTo: temperature.leadingAnchor),
            location.topAnchor.constraint(equalToSystemSpacingBelow: temperature.bottomAnchor, multiplier: 1),

            weatherIcon.widthAnchor.constraint(equalTo: weatherCard.heightAnchor, multiplier: 0.4),
            weatherIcon.heightAnchor.constraint(equalTo: weatherIcon.widthAnchor),
            weatherIcon.trailingAnchor.constraint(equalTo: weatherCard.trailingAnchor, constant: -30),
            weatherIcon.topAnchor.constraint(equalToSystemSpacingBelow: weatherCard.topAnchor, multiplier: 2),

            uvIndex.leadingAnchor.constraint(equalTo: temperature.leadingAnchor),
            uvIndex.topAnchor.constraint(equalToSystemSpacingBelow: location.bottomAnchor, multiplier: 1),

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
