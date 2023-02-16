//
//  LocalPersistenceManager.swift
//  WeCare
//
//  Created by Yago Marques on 16/02/23.
//

import Foundation
import CoreData

enum CoreDataError: Error {
    case invalidDecode
}

struct LocalPersistanceManager {
    let persistentContainer: NSPersistentContainer

    init(persistentContainer: NSPersistentContainer = CoreDataStack.persistentContainer) {
        self.persistentContainer = persistentContainer
    }
}

extension LocalPersistanceManager: DailyControl {

    func updateDate() throws {
        let context = persistentContainer.viewContext
        let dateEntity = DateEntity(context: context)

        dateEntity.date = Date()

        do {
            try context.save()
        } catch {
            throw error
        }
    }

    func fetchDate() throws -> Date? {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<DateEntity>(entityName: "DateEntity")
        fetchRequest.fetchLimit = 1

        do {
            let dateEntity = try context.fetch(fetchRequest)
            return dateEntity.first?.date
        } catch let error {
            throw error
        }
    }

    func isToday() throws -> Bool {
        do {
            return try self.fetchDate()?.displayFormat == Date().displayFormat
        } catch {
            throw error
        }
    }
}

extension LocalPersistanceManager: TasksControl {
    func createTask(_ task: NotificationsTask) throws {
        do {
            let context = persistentContainer.viewContext
            let data = try JSONEncoder().encode(task)
            let taskEntity = TaskEntity(context: context)

            taskEntity.data = data
            taskEntity.id = task.id

            try context.save()
        } catch {
            throw error
        }
    }

    func fetchTasks() throws -> [NotificationsTask]? {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<TaskEntity>(entityName: "TaskEntity")

        do {
            let dateEntity = try context.fetch(fetchRequest)
            return try dateEntity.map { entity in
                if let data = entity.data {
                    return try JSONDecoder().decode(NotificationsTask.self, from: data)
                } else { throw CoreDataError.invalidDecode }
            }
        } catch let error {
            throw error
        }
    }

    private func fetchRawTasks() throws -> [TaskEntity]? {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<TaskEntity>(entityName: "TaskEntity")

        do {
            return try context.fetch(fetchRequest)
        } catch let error {
            throw error
        }
    }

    func markAsDone(taskId: UUID) throws {
        do {
            let context = persistentContainer.viewContext
            let tasks = try self.fetchRawTasks()
            let filteredTask = tasks?.filter { $0.id == taskId }
            let taskEntity = filteredTask?.first

            guard let data = taskEntity?.data else { throw CoreDataError.invalidDecode }
            var notificationTask = try JSONDecoder().decode(NotificationsTask.self, from: data)
            notificationTask.isDone = true

            taskEntity?.data = try JSONEncoder().encode(notificationTask)

            try context.save()
        } catch {
            throw error
        }
    }

    func removeAll() throws {
        do {
            let context = persistentContainer.viewContext
            let tasks = try self.fetchRawTasks()

            if let tasks {
                tasks.forEach { task in
                    context.delete(task)
                }
            }

            try context.save()
        } catch {
            throw error
        }
    }
}
