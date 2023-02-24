//
//  LocalNotificationLoader.swift
//  WeCare
//
//  Created by Yago Marques on 23/02/23.
//

import Foundation

protocol TaskLoader: AnyObject {
    func updateTasksIfNeeded(uvIndex: Int, temperature: Int) throws
    func getTasks() throws -> [NotificationsTask]?
    func startDateIfNeeded() throws
}

final class LocalNotificationLoader {
    let dailyControl: DailyControl
    let tasksControl: TasksControl

    init(dailyControl: DailyControl, tasksControl: TasksControl) {
        self.dailyControl = dailyControl
        self.tasksControl = tasksControl
    }
}

extension LocalNotificationLoader: TaskLoader {
    func getTasks() throws -> [NotificationsTask]? {
        try tasksControl.fetchTasks()
    }

    func updateTasksIfNeeded(uvIndex: Int, temperature: Int) throws {
        try verifyDate()
        try registerMorningTasksIfNeeded()
        try registerAfternoonTasksIfNeeded(uvIndex: uvIndex, temperature: temperature)
        try registerEveningTasksIfNeeded()
    }

    func startDateIfNeeded() throws {
        let defaults = UserDefaults.standard
        if !defaults.bool(forKey: "firstTime") {
            try dailyControl.updateDate()
            defaults.set(true, forKey: "firstTime")
        }
    }
}

private extension LocalNotificationLoader {
    private func verifyTemperature(currentTemperature: Int, min: Int, max: Int) -> Bool {
        currentTemperature >= min && currentTemperature <= max
    }

    private func verifyDate() throws {
        let coreDataDateIsToday: Bool = try dailyControl.isToday()
        if !coreDataDateIsToday {
            try tasksControl.removeAll()
            try dailyControl.updateDate()
        }
    }

    private func verifyUvIndex(currentUvIndex: Int, min: Int, max: Int) -> Bool {
        currentUvIndex >= min && currentUvIndex <= max
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

    private func setMorningTasks() throws {
        for task in NotificationsTask.getMorningTasks() {
            try tasksControl.createTask(task)
        }
    }

    private func setEveningTasks() throws {
        try NotificationsTask.getEveningTasks().forEach { try tasksControl.createTask($0) }
    }

    private func isPossibleLoaderNewTask() throws -> Bool {
        guard let currentTasks = try tasksControl.fetchTasks() else { return false }
        guard let lastTask = currentTasks.last else { return false }
        let hourDifference = Date().getHour - lastTask.hour

        return hourDifference >= 4
    }

    private func tasksIsEmpty() throws -> Bool {
        guard let currentTasks = try tasksControl.fetchTasks() else { return false }

        return currentTasks.isEmpty
    }

    private func registerMorningTasksIfNeeded() throws {
        if
            Date().getHour <= 12,
            try tasksIsEmpty()
        {
            try setMorningTasks()
        }
    }

    private func registerEveningTasksIfNeeded() throws {
        if
            Date().getHour >= 18,
            (try isPossibleLoaderNewTask() || tasksIsEmpty())
        {
            try setEveningTasks()
        }
    }

    private func registerAfternoonTasksIfNeeded(uvIndex: Int, temperature: Int) throws {
        if
            Date().getHour > 12,
            Date().getHour < 18,
            (try isPossibleLoaderNewTask() || tasksIsEmpty())
        {
            try setNewTesks(uvIndex: uvIndex, temperature: temperature)
        }
    }
}
