//
//  NotificationsTasksViewModel.swift
//  WeCare
//
//  Created by Yago Marques on 14/02/23.
//

import Foundation

struct NotificationsTasksViewModel {
    let tasks: [NotificationsTask]
}

struct NotificationsTask: Codable {
    let id: UUID
    let useCases: TasksUseCase?
    let title: String
    let description: String
    let icon: String
    let voiceIcon: String
    let stepsDescription: String
    let steps: [TaskStep]
    var isDone: Bool
    let hour: Double
}

struct TaskStep: Codable {
    let title: String
    let description: String
}

struct TasksUseCase: Codable {
    let minTemperature: Int
    let minUvIndex: Int
    let maxTemperature: Int
    let maxUvIndex: Int
}
