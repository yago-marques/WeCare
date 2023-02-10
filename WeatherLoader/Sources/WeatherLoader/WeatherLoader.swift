//
//  WeatherLoader.swift
//
//
//  Created by Yago Marques on 08/02/23.
//

import Foundation
import WeatherKit

public struct WeatherInfo {
    let location: WorldLocation
    let temperature: String
    let humidity: Double
    let uvIndex: Int
    let symbolName: String
}

@available(iOS 16.0, *)
public final class WeatherLoader {
    public var weather: Weather?
    let location = LocationManager()
    let map = MapHelper()

    public init() { }

    public func play(completion: @escaping (WeatherInfo) -> Void) async throws {
        try await findWeather()
        try findAddress() { address in
            guard let weather = self.weather else { return }
            completion(
                .init(
                    location: address,
                    temperature: weather.currentWeather.temperature.formatted(),
                    humidity: weather.currentWeather.humidity,
                    uvIndex: weather.currentWeather.uvIndex.value,
                    symbolName: weather.currentWeather.symbolName
                )
            )
        }
    }

    private func findWeather() async throws {
        do {
            weather = try await WeatherService.shared.weather(
                for: .init(
                    latitude: self.location.latitude,
                    longitude: self.location.longitude
                )
            )
        } catch {
            throw error
        }
    }

    private func findAddress(completion: @escaping (WorldLocation) -> Void) throws {
        map.getAddress(
            latitude: self.location.latitude,
            longitude: self.location.longitude
        ) { result in
            switch result {
            case .success(let success):
                completion(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
