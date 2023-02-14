//
//  DailyTasksController.swift
//  WeCare
//
//  Created by Yago Marques on 13/02/23.
//

import Foundation
import UIKit

final class DailyTasksController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view = DailyTasksView(frame: UIScreen.main.bounds)
    }
    
}
