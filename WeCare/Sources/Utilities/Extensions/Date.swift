//
//  Date.swift
//  WeCare
//
//  Created by Yago Marques on 13/02/23.
//

import Foundation

extension Date {
    var displayFormat: String {
        self.formatted(date: .long, time: .omitted)
    }

    var greetingMessage: String {
        let hour = Calendar.current.component(.hour, from: Date())
        if hour <= 12 {
            return "Bom dia"
        } else if hour > 12 && hour < 18 {
            return "Boa tarde"
        }
        return "Boa noite"
    }
}
