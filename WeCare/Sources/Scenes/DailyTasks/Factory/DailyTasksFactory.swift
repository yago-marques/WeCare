//
//  DailyTasksFactory.swift
//  WeCare
//
//  Created by Yago Marques on 13/02/23.
//

import Foundation
import UIKit

enum DailyTasksFactory {
    static func make() -> UIViewController {
        DailyTasksController()
    }
}
