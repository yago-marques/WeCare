//
//  Double.swift
//  WeCare
//
//  Created by Yago Marques on 24/02/23.
//

import Foundation

extension Double {
    func round(to places: Int) -> String {
        String(format: "%.\(places)f", self)
    }
}
