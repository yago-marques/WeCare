//
//  DailyControl.swift
//  WeCare
//
//  Created by Yago Marques on 16/02/23.
//

import Foundation

protocol DailyControl {
    func updateDate() throws
    func fetchDate() throws -> Date?
    func isToday() throws -> Bool
    func startDate() throws
}
