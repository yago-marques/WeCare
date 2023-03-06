//
//  NofificationFactory.swift
//  WeCare
//
//  Created by Yago Marques on 03/03/23.
//

import Foundation

enum NotificationFactory {
    static func make() -> NotificationManaging {
        NotificationManager(
            taskLoader: LocalNotificationLoader(
                dailyControl: LocalPersistanceManager(),
                tasksControl: LocalPersistanceManager()
            )
        )
    }
}
