//
//  WeatherIconModel.swift
//  WeCare
//
//  Created by Stephane Girão Linhares on 05/03/23.
//

import Foundation

struct WeatherIconModel {
    var weatherIconName: String
    var weatherIconDescription: String

    init(weatherIconName: String, weatherIconDescription: String) {
        self.weatherIconName = weatherIconName
        self.weatherIconDescription = weatherIconDescription
    }
}
