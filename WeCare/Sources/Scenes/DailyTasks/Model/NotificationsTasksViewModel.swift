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

struct NotificationsTask {
    let title: String
    let description: String
    let icon: String
    let steps: (String, [TaskStep])
}

struct TaskStep {
    let title: String
    let description: String
}
