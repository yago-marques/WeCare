//
//  LocationManager.swift
//  
//
//  Created by Yago Marques on 08/02/23.
//

import Foundation
import CoreLocation

@available(iOS 16.0, *)
public class LocationManager: NSObject, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    public var authorizationStatus: CLAuthorizationStatus?

    public var latitude: Double {
        locationManager.location?.coordinate.latitude ?? 0.0
    }
    public var longitude: Double {
        locationManager.location?.coordinate.longitude ?? 0.0
    }

    public override init() {
        super.init()
        locationManager.delegate = self
    }

    public func makeRequest() {
        locationManager.requestWhenInUseAuthorization()
    }

    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) { }

    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            authorizationStatus = .authorizedWhenInUse
            locationManager.requestLocation()
            break

        case .restricted:
            authorizationStatus = .restricted
            break

        case .denied:
            authorizationStatus = .denied
            break

        case .notDetermined:
            authorizationStatus = .notDetermined
            manager.requestWhenInUseAuthorization()
            break

        default:
            break
        }
    }

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error.localizedDescription)")
    }
}



