//
//  WeatherLoader.swift
//
//
//  Created by Yago Marques on 08/02/23.
//

import Foundation
import WeatherKit

enum WeatherError: Error {
    case invalidWeather
}

public struct WeatherInfo {
    public let location: WorldLocation
    public let temperature: String
    public let uvIndex: Int
    public let symbolName: String
    public let weatherIconDescription: String
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
                    uvIndex: weather.currentWeather.uvIndex.value,
                    symbolName: weather.currentWeather.symbolName
                )
            )
        }
    }

    public func getWeather() async throws -> WeatherInfo {
        try await findWeather()
        let address = try await findAddress()
        guard let weather = self.weather else { throw WeatherError.invalidWeather }

        return .init(
            location: address,
            temperature: weather.currentWeather.temperature.formatted(),
            uvIndex: weather.currentWeather.uvIndex.value,
            symbolName: weather.currentWeather.symbolName
        )
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

    private func findAddress() async throws -> WorldLocation {
        do {
            return try await map.getAddress(
                latitude: self.location.latitude,
                longitude: self.location.longitude
            )
        } catch {
            throw error
        }
    }
}
