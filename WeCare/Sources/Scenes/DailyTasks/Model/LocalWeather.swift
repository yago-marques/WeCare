//
//  LocalWeather.swift
//  WeCare
//
//  Created by Yago Marques on 14/02/23.
//

import Foundation

struct LocalWeather {
    let temperature: String
    let uvIndex: Int
    let city: String
    let country: String
    var weatherIcon: String
    var weatherIconDescription: String

    func getTemperature() -> Int {
        let stringNumbers = temperature.filter { item in
            let possibleInt = Int(String(item))
            return possibleInt != nil ? true : false
        }

        return Int(stringNumbers) ?? 200
    }
}
