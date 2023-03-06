//
//  NotificationManager.swift
//  WeCare
//
//  Created by Yago Marques on 03/03/23.
//

import Foundation
import UserNotifications

protocol NotificationManaging {
    func deliveryNotifications() throws
}

final class NotificationManager: NotificationManaging {
    let taskLoader: TaskLoader

    init(taskLoader: TaskLoader) {
        self.taskLoader = taskLoader
    }

    func deliveryNotifications() throws {
        self.getAccess()

        try getNotification()
    }
}

extension NotificationManager {
    private func getAccess() {
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .badge, .sound]) { success, _ in
        }
    }

    private func getNotification() throws {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()

        try getTriggers().forEach { trigger in
            let id = UUID().uuidString
            let request = UNNotificationRequest(
                identifier: id, content: getContent(), trigger: trigger)

            UNUserNotificationCenter.current().add(request) { error in
                if let error {
                    print(error)
                }
            }
        }
    }

    private func getContent() -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = "Hora de cuidar da sua pele"
        content.body = "Confira no aplicativo os cuidados recomendados"
        content.sound = .default

        return content
    }

    private func getTriggers() throws -> [UNTimeIntervalNotificationTrigger] {
        let hour = Date().getHour

        if hour <= 12 {
            return try getMorningTriggers()
        } else if hour > 12 && hour < 18 {
            return try getDefaultsTriggers()
        }

        return try getEveningTriggers()
    }

    private func getMorningTriggers() throws -> [UNTimeIntervalNotificationTrigger] {
        guard let tasks = try taskLoader.getTasks() else { return [] }
        guard let lastTaskHour = tasks.last?.hour else { return [] }
        let nextTaskHour = lastTaskHour + 4

        if nextTaskHour <= 12 {
            return [
                .init(timeInterval: getInterval(12 - Date().getHour), repeats: false)
            ]
        } else {
            return try getDefaultsTriggers()
        }
    }

    private func getDefaultsTriggers() throws -> [UNTimeIntervalNotificationTrigger] {
        guard let tasks = try taskLoader.getTasks() else { return [] }
        if tasks.isEmpty {
            return [
                .init(timeInterval: getInterval(1), repeats: false)
            ]
        } else {
            guard let lastTaskHour = tasks.last?.hour else { return [] }
            let nextTaskHour = lastTaskHour + 4
            let differenceToNextTask = nextTaskHour - Date().getHour

            if differenceToNextTask >= 4 {
                return [
                    .init(timeInterval: getInterval(4), repeats: false)
                ]
            } else {
                return [
                    .init(timeInterval: getInterval(4 - differenceToNextTask), repeats: false)
                ]
            }
        }
    }

    private func getEveningTriggers() throws -> [UNTimeIntervalNotificationTrigger] {
        guard let tasks = try taskLoader.getTasks() else {
            return [.init(timeInterval: getInterval(32 - Date().getHour), repeats: false)]
        }
        guard let lastTaskHour = tasks.last?.hour else {
            return [.init(timeInterval: getInterval(32 - Date().getHour), repeats: false)]
        }
        let nextTaskHour = lastTaskHour + 4

        if tasks.isEmpty {
            return [.init(timeInterval: getInterval(32 - Date().getHour), repeats: false)]
        } else {
            let differenceToNextTask = nextTaskHour - Date().getHour

            if differenceToNextTask >= 4, nextTaskHour <= 21.3 {
                return [
                    .init(timeInterval: getInterval(4), repeats: false)
                ]
            } else if nextTaskHour <= 21.3 {
                return [
                    .init(timeInterval: getInterval(4 - differenceToNextTask), repeats: false)
                ]
            } else {
                return [.init(timeInterval: getInterval(32 - Date().getHour), repeats: false)]
            }
        }
    }

    private func getInterval(_ time: Double) -> TimeInterval {
        (60*60)*time
    }
}
