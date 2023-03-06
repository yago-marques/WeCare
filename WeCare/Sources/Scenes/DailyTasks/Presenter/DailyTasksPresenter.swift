//
//  DailyTasksPresenter.swift
//  WeCare
//
//  Created by Yago Marques on 14/02/23.
//

import Foundation

protocol DailyTasksPresenting: AnyObject {
    func showView(_ controller: DailyTasksController) async throws
    func markTaskAsDone(id: UUID) throws
    func getTasksProgressViewModel() throws -> TasksProgressViewModel?
}

final class DailyTasksPresenter {
    weak var controller: DailyTasksController?
    let weatherService: WeatherClient
    let taskLoader: TaskLoader
    let systemNotification: NotificationManaging

    var interfaceModel = DailyTasksViewModel() {
        didSet {
            updateInterface()
        }
    }

    init(
        controller: DailyTasksController? = nil,
        weatherService: WeatherClient,
        taskLoader: TaskLoader,
        systemNotification: NotificationManaging
    ) {
        self.controller = controller
        self.weatherService = weatherService
        self.taskLoader = taskLoader
        self.systemNotification = systemNotification
    }
    
}

extension DailyTasksPresenter: DailyTasksPresenting {
    func getTasksProgressViewModel() throws -> TasksProgressViewModel? {
        guard let tasks = try taskLoader.getTasks() else { return nil }
        let doneTasks = tasks.filter { $0.isDone == true }

        return .init(
            allTasksCount: tasks.count,
            doneTasksCount: doneTasks.count,
            doneTasks: doneTasks
        )
    }

    func showView(_ controller: DailyTasksController) async throws {
        self.controller = controller
        incrementView()
        loadHeader()
        try loadWeatherCard() {
            try self.updateTasksIfNeeded()
            try self.loadNotificationTable()
            try self.systemNotification.deliveryNotifications()
        }
    }

    func markTaskAsDone(id: UUID) throws {
        try taskLoader.markTaskAsDone(id: id)
        try loadNotificationTable()
        if let tasksViewModel = try self.getTasksProgressViewModel() {
            interfaceModel.weatherCard?.tasksViewModel = tasksViewModel
        }

    }
}

private extension DailyTasksPresenter {
    private func updateInterface() {
        DispatchQueue.main.async {
            self.controller?.reloadData {
                self.controller?.dailyView.setup(viewModel: self.interfaceModel)
            }
        }
    }

    private func incrementView() {
        guard let controller else { return }
        DispatchQueue.main.async {
            controller.view = controller.dailyView
        }

        try? taskLoader.startDateIfNeeded()
    }

    private func loadHeader() {
        self.interfaceModel.header = .init(userName: "Usuário")
    }

    private func loadWeatherCard(completion: @escaping () throws -> Void) throws {
        try weatherService.getWeather() { weather in
            guard let tasksViewModel = try self.getTasksProgressViewModel() else { return }
            self.interfaceModel.weatherCard = .init(
                weather: weather,
                tasksViewModel: tasksViewModel
            )
            self.controller?.removeWeatherAnimation()
            try completion()
        }
    }

    private func updateTasksIfNeeded() throws {
        let temperature = interfaceModel.weatherCard?.weather.getTemperature() ?? 0
        let uvIndex = interfaceModel.weatherCard?.weather.uvIndex ?? 0

        try taskLoader.updateTasksIfNeeded(uvIndex: uvIndex, temperature: temperature)
    }

    private func loadNotificationTable() throws {
        guard let tasks = try taskLoader.getTasks() else { return }
        let unDoneTasks = tasks.filter { $0.isDone == false }
        self.interfaceModel.notificationsTable = .init(tasks: unDoneTasks)
    }

}
