//
//  ViewController.swift
//  WeCare
//
//  Created by Yago Marques on 06/02/23.
//

import UIKit
import WeatherLoader

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        Task.detached {
            let locationManager = LocationManager()
            if locationManager.authorizationStatus != .authorizedWhenInUse {
                locationManager.makeRequest()
            }
        }

        Task.detached {
            do {
                let service = WeatherLoader()
                try await service.play() { weatherData in
                    print(weatherData)
                }
            } catch {
                print(error)
            }
        }
    }

}
