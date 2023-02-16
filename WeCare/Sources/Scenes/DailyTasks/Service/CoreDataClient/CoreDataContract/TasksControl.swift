//
//  TasksControl.swift
//  WeCare
//
//  Created by Yago Marques on 16/02/23.
//

import Foundation

protocol TasksControl {
    func createTask(_ task: NotificationsTask) throws
    func fetchTasks() throws -> [NotificationsTask]?
    func markAsDone(taskId: UUID) throws
    func removeAll() throws
}
