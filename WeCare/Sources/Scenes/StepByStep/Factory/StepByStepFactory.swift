//
//  StepByStepFactory.swift
//  WeCare
//
//  Created by Yago Marques on 25/02/23.
//

import Foundation
import UIKit

enum StepByStepFactory {
    static func make(viewModel: NotificationsTask) -> UIViewController {
        StepByStepViewController(viewModel: viewModel)
    }
}
