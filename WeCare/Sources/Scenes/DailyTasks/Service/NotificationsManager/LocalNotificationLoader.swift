//
//  LocalNotificationLoader.swift
//  WeCare
//
//  Created by Yago Marques on 23/02/23.
//

import Foundation

final class LocalNotificationLoader {
    let dailyControl: DailyControl
    let tasksControl: TasksControl

    init(dailyControl: DailyControl, tasksControl: TasksControl) {
        self.dailyControl = dailyControl
        self.tasksControl = tasksControl
    }

    func startDate() throws {
        try dailyControl.updateDate()
    }

    func verifyDate() throws {
        let coreDataDateIsToday: Bool = try dailyControl.isToday()
        if !coreDataDateIsToday {
            try tasksControl.removeAll()
            try dailyControl.updateDate()
        }
    }

    private func setMorningTasks() throws {
        for task in NotificationsTask.getMorningTasks() {
            try tasksControl.createTask(task)
        }
    }

    private func setEveningTasks() throws {
        try NotificationsTask.getEveningTasks().forEach { try tasksControl.createTask($0) }
    }

    private func setNewTesks(uvIndex: Int, temperature: Int) throws {
        let filteredCases = getValidCases(uvIndex: uvIndex, temperature: temperature)

        for filteredCase in filteredCases {
            try tasksControl.createTask(filteredCase)
        }
    }

    private func getValidCases(uvIndex: Int, temperature: Int) -> [NotificationsTask] {
        let allCases = NotificationsTask.getUseCases()

        let filteredCases = allCases.filter { caseObject in
            if let useCases = caseObject.useCases {
                let validTemperature = verifyTemperature(currentTemperature: temperature, min: useCases.minTemperature, max: useCases.maxTemperature)
                let validUvIndex = verifyUvIndex(currentUvIndex: uvIndex, min: useCases.minUvIndex, max: useCases.maxUvIndex)

                return validTemperature && validUvIndex
            }
            return false
        }

        return filteredCases
    }

    private func verifyTemperature(currentTemperature: Int, min: Int, max: Int) -> Bool {
        currentTemperature >= min && currentTemperature <= max
    }

    private func verifyUvIndex(currentUvIndex: Int, min: Int, max: Int) -> Bool {
        currentUvIndex >= min && currentUvIndex <= max
    }

    private func showMoringTasksIfNeeded() throws {
        if Date().getHour <= 12 {
            try setMorningTasks()
        }
    }

    private func showEveningTasksIfNeeded() throws {
        if Date().getHour >= 18 {
            try setEveningTasks()
        }
    }

}
