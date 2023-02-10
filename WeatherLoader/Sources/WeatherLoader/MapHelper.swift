//
//  MapHelper.swift
//  
//
//  Created by Yago Marques on 09/02/23.
//

import Foundation
import MapKit

public struct WorldLocation {
    let city: String
    let country: String
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
}

extension CLLocation {
    func fetchCityAndCountry(completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $0?.first?.country, $1) }
    }
}
