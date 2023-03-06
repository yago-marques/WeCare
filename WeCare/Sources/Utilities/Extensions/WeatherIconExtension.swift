//
//  WeatherIconExtension.swift
//  WeCare
//
//  Created by Stephane Girão Linhares on 05/03/23.
//

import Foundation

extension WeatherIconModel {
    static func getIconDescription() -> [WeatherIconModel] {
        [
            .init(
                weatherIconName: "cloud.bolt.rain",
                weatherIconDescription: "nuvem chovendo com raios"
            ),
            .init(
                weatherIconName: "moon",
                weatherIconDescription: "lua com estrelas"
            )
        ]
    }
}
