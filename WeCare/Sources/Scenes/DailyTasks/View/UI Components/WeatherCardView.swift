//
//  WeatherCardView.swift
//  WeCare
//
//  Created by Emilly Maia on 10/02/23.
//

import Foundation
import UIKit

class WeatherCardView: UIView {
    
    let weatherCard: UIView = {
        let card = UIView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.backgroundColor = .clear
        card.layer.shadowColor = UIColor.black.cgColor
        card.layer.shadowOffset = CGSizeMake(2.5, 2.5)
        card.layer.shadowRadius = 0.9
        card.layer.shadowOpacity = 0.2
        card.layer.cornerCurve = .circular
        card.layer.cornerRadius = 20
        return card
    }()

    internal let groupAccessibleCard: UIView = {
        let card = UIView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.backgroundColor = .clear
        card.layer.shadowColor = UIColor.black.cgColor
        card.layer.shadowOffset = CGSizeMake(2.5, 2.5)
        card.layer.shadowRadius = 0.9
        card.layer.shadowOpacity = 0.2
        card.layer.cornerCurve = .circular
        card.layer.cornerRadius = 20
        return card
    }()
    
    let background: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.image = UIImage(named: "weatherCardBackground")
        return image
    }()

    private let progressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Cuidados feitos"

        return label
    }()

    private let progressBar: ProgressBar = {
        let progress = ProgressBar()
        progress.translatesAutoresizingMaskIntoConstraints = false

        return progress
    }()
    
    private let weatherIcon: UIImageView =  {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit
        icon.tintColor = UIColor(red: 0.99, green: 0.97, blue: 1, alpha: 1)
        return icon
    }()
    
    private let temperature: UILabel = {
        let temperature = UILabel()
        temperature.translatesAutoresizingMaskIntoConstraints = false
        temperature.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        temperature.tintColor = .systemGray
        return temperature
    }()
    
    private let location: UILabel = {
        let location = UILabel()
        location.translatesAutoresizingMaskIntoConstraints = false
        location.adjustsFontForContentSizeCategory = true
        location.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return location
    }()
    
    private let uvIndex: UILabel = {
        let uvIndex = UILabel()
        uvIndex.translatesAutoresizingMaskIntoConstraints = false
        uvIndex.adjustsFontForContentSizeCategory = true
        uvIndex.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return uvIndex
    }()

    private let uvIndexInt: UILabel = {
        let uvIndexInt = UILabel()
        uvIndexInt.translatesAutoresizingMaskIntoConstraints = false
        uvIndexInt.adjustsFontForContentSizeCategory = true
        uvIndexInt.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return uvIndexInt
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
        temperature.text = viewModel.weather.temperature
        uvIndex.text = " | Índice UV: \(viewModel.weather.uvIndex)"
        uvIndexInt.text = "\(viewModel.weather.uvIndex)"
        addProgressBar()
        progressBar.setup(viewModel: viewModel.tasksViewModel)
        groupAccessible()
    }

    func addProgressBar() {
        weatherCard.addSubview(progressBar)
        weatherCard.addSubview(progressLabel)

        NSLayoutConstraint.activate([
            progressBar.leadingAnchor.constraint(equalToSystemSpacingAfter: weatherCard.leadingAnchor, multiplier: 2),
            progressBar.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 15),
            progressBar.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.35),
            progressBar.heightAnchor.constraint(equalTo: progressBar.widthAnchor, multiplier: 0.2),

            progressLabel.bottomAnchor.constraint(equalTo: progressBar.topAnchor, constant: -3),
            progressLabel.leadingAnchor.constraint(equalTo: progressBar.leadingAnchor, constant: 10)
        ])
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
            
            background.widthAnchor.constraint(equalTo: weatherCard.widthAnchor),
            background.heightAnchor.constraint(equalTo: weatherCard.heightAnchor),
            background.centerXAnchor.constraint(equalTo: weatherCard.centerXAnchor),
            background.centerYAnchor.constraint(equalTo: weatherCard.centerYAnchor),

            groupAccessibleCard.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            groupAccessibleCard.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6),
            groupAccessibleCard.centerXAnchor.constraint(equalTo: weatherCard.centerXAnchor),
            groupAccessibleCard.centerYAnchor.constraint(equalTo: weatherCard.centerYAnchor),

            temperature.leadingAnchor.constraint(equalTo: weatherIcon.leadingAnchor),
            temperature.topAnchor.constraint(equalTo: uvIndex.topAnchor),

            weatherIcon.widthAnchor.constraint(equalTo: weatherCard.heightAnchor, multiplier: 0.4),
            weatherIcon.heightAnchor.constraint(equalTo: weatherIcon.widthAnchor),
            weatherIcon.trailingAnchor.constraint(equalTo: weatherCard.trailingAnchor, constant: -50),
            weatherIcon.topAnchor.constraint(equalToSystemSpacingBelow: safeAreaLayoutGuide.topAnchor, multiplier: 5),

            uvIndex.topAnchor.constraint(equalToSystemSpacingBelow: weatherIcon.bottomAnchor, multiplier: 2),
            uvIndex.leadingAnchor.constraint(equalTo: temperature.trailingAnchor)
        ])
    }

    func setupHierarchy() {
        addSubview(weatherCard)
        weatherCard.addSubview(background)
        weatherCard.addSubview(groupAccessibleCard)
        weatherCard.addSubview(weatherIcon)
        weatherCard.addSubview(temperature)
        weatherCard.addSubview(uvIndex)
    }

}

extension WeatherCardView {
    private func groupAccessible() {

        self.weatherIcon.isAccessibilityElement = false
        self.weatherCard.isAccessibilityElement = false
        self.background.isAccessibilityElement = false
        self.location.isAccessibilityElement = false
        self.temperature.isAccessibilityElement = false
        self.uvIndex.isAccessibilityElement = false
        self.progressLabel.isAccessibilityElement = false
        self.progressBar.isAccessibilityElement = false
        self.groupAccessibleCard.isAccessibilityElement = true

        groupAccessibleCard.accessibilityLabel = "Número de \((progressLabel.text ?? "erro")), \(progressBar.viewModel.doneTasksCount) de  \(progressBar.viewModel.allTasksCount), temperatura \((temperature.text ?? "erro")), com Índice UV: \(uvIndexInt.text ?? "erro")"
    }
}
