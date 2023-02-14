//
//  MapHelper.swift
//  
//
//  Created by Yago Marques on 09/02/23.
//

import Foundation
import MapKit

public struct WorldLocation {
    public let city: String
    public let country: String
}

enum MapError: Error {
    case invalidLocation
}

class MapHelper {
    func getAddress(
        latitude: Double,
        longitude: Double,
        completion: @escaping (Result<WorldLocation, Error>) -> Void
    ) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        location.fetchCityAndCountry { city, country, error in
            if let error { completion(.failure(error)) }
            guard let city, let country else { return }
            completion(.success(.init(city: city, country: country)))
        }
    }

    func getAddress(
        latitude: Double,
        longitude: Double
    ) async throws -> WorldLocation{
        let location = CLLocation(latitude: latitude, longitude: longitude)
        do {
            let (city, country, _) = try await location.fetchCityAndCountry()
            guard let city, let country else { throw MapError.invalidLocation }

            return .init(city: city, country: country)
        } catch {
            throw error
        }

    }
}

extension CLLocation {
    // MARK: TODO mudar a chamada do reverseGeocodeLocation pra async/await
    /// Bonus: ver sobre como usar Tasks e retornar valores nela pra usar na completion (TaskGroup, withCheckedContinuation, etc)
    func fetchCityAndCountry(completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $0?.first?.country, $1) }
    }

    func fetchCityAndCountry() async throws -> (city: String?, country:  String?, error: Error?) {
        do {
            let placemarks = try await CLGeocoder().reverseGeocodeLocation(self)

            return (placemarks.first?.locality, placemarks.first?.country, nil)
        } catch {
            return (nil, nil, error)
        }

    }


}
