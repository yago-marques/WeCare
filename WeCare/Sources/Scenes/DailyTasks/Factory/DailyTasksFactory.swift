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
        let view = DailyTasksView(frame: UIScreen.main.bounds)
        let presenter = DailyTasksPresenter(
            weatherService: RemoteWeatherLoader(),
            taskLoader: LocalNotificationLoader(
                dailyControl: LocalPersistanceManager(),
                tasksControl: LocalPersistanceManager()
            )
        )

        return DailyTasksController(
            dailyView: view,
            presenter: presenter
        )
    }
}
