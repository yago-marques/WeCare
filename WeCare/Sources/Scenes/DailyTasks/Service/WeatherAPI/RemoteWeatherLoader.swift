//
//  RemoteWeatherLoader.swift
//  WeCare
//
//  Created by Yago Marques on 14/02/23.
//

import Foundation
import WeatherLoader

protocol WeatherClient: AnyObject {
    var weather: LocalWeather {get set}
    func getWeather(completion: @escaping (LocalWeather) throws -> Void) throws
}

final class RemoteWeatherLoader {

    let locationManager = LocationManager()
    let weatherLoader = WeatherLoader()
    var weather: LocalWeather = .init(
        temperature: "--",
        uvIndex: 0,
        city: "--",
        country: "--",
        weatherIcon: "sun"
    ) {
        didSet {
            print(weather)
        }
    }

    private func getLocationAccess() {
        Task.detached {
            if self.locationManager.authorizationStatus != .authorizedWhenInUse {
                self.locationManager.makeRequest()
            }
        }
    }

    private func makeWeather(_ rawWeather: WeatherInfo) -> LocalWeather {
        .init(
            temperature: rawWeather.temperature,
            uvIndex: rawWeather.uvIndex,
            city: rawWeather.location.city,
            country: rawWeather.location.country,
            weatherIcon: rawWeather.symbolName
        )
    }

    private func fetchWeather() {

    }

}

extension RemoteWeatherLoader: WeatherClient {
    func getWeather(completion: @escaping (LocalWeather) throws -> Void) throws {
        locationManager.completion = {
            Task {
                try completion(self.makeWeather(try await self.weatherLoader.getWeather()))
            }
        }
        getLocationAccess()
    }
}
