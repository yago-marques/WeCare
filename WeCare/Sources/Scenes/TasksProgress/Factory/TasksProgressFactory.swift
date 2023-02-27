//
//  TasksProgressFactory.swift
//  WeCare
//
//  Created by Yago Marques on 26/02/23.
//

import Foundation
import UIKit

enum TasksProgressFactory {
    static func make(viewModel: TasksProgressViewModel) -> UIViewController {
        TasksProgressController(
            tasksProgressView: TasksProgressView(frame: UIScreen.main.bounds),
            viewModel: viewModel
        )
    }
}
