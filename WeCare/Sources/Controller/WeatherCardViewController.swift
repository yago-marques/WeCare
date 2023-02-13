//
//  WeatherCardViewController.swift
//  WeCare
//
//  Created by Emilly Maia on 13/02/23.
//

import Foundation
import UIKit

class WeatherCardViewController: UIViewController {
    
   private var weatherCardView = WeatherCardView()
    
    override func viewDidLoad() {
        view = weatherCardView
    }
}
