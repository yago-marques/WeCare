//
//  RemoteWeatherLoader.swift
//  WeCare
//
//  Created by Yago Marques on 14/02/23.
//

import Foundation
import WeatherLoader

protocol WeatherClient: AnyObject {
    func getWeather() async throws -> LocalWeather
}

final class RemoteWeatherLoader {

    let locationManager = LocationManager()
    let weatherLoader = WeatherLoader()

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

}

extension RemoteWeatherLoader: WeatherClient {
    func getWeather() async throws -> LocalWeather {
        getLocationAccess()
        do {
            return makeWeather(try await weatherLoader.getWeather())
        } catch {
            throw error
        }
    }

}
