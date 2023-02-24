//
//  DailyTasksPresenter.swift
//  WeCare
//
//  Created by Yago Marques on 14/02/23.
//

import Foundation

protocol DailyTasksPresenting: AnyObject {
    func showView(_ controller: DailyTasksController) async throws
}

final class DailyTasksPresenter {
    weak var controller: DailyTasksController?
    let weatherService: WeatherClient
    let taskLoader: TaskLoader

    var interfaceModel = DailyTasksViewModel()

    init(
        controller: DailyTasksController? = nil,
        weatherService: WeatherClient,
        taskLoader: TaskLoader
    ) {
        self.controller = controller
        self.weatherService = weatherService
        self.taskLoader = taskLoader
    }
    
}

extension DailyTasksPresenter: DailyTasksPresenting {
    func showView(_ controller: DailyTasksController) async throws {
        self.controller = controller
        incrementView()
        loadHeader()
        try await loadWeatherCard()
        try updateTasksIfNeeded()
        try loadNotificationTable()
        updateInterface()
    }
}

private extension DailyTasksPresenter {
    private func updateInterface() {
        DispatchQueue.main.async {
            self.controller?.dailyView.setup(viewModel: self.interfaceModel)
        }
    }

    private func incrementView() {
        guard let controller else { return }
        DispatchQueue.main.async {
            controller.view = controller.dailyView
            controller.title = "WeCare"
        }

        try? taskLoader.startDateIfNeeded()
    }

    private func loadHeader() {
        self.interfaceModel.header = .init(userName: "Usuário")
    }

    private func loadWeatherCard() async throws {
//        self.interfaceModel.weatherCard = DailyTasksViewModel.getMock().weatherCard
    
        do {
            let weather = try await weatherService.getWeather()
            self.interfaceModel.weatherCard = .init(weather: weather)
        } catch {
            throw error
        }
    }

    private func updateTasksIfNeeded() throws {
        let temperature = interfaceModel.weatherCard?.weather.getTemperature() ?? 0
        let uvIndex = interfaceModel.weatherCard?.weather.uvIndex ?? 0

        try taskLoader.updateTasksIfNeeded(uvIndex: uvIndex, temperature: temperature)

//        try taskLoader.updateTasksIfNeeded(uvIndex: 4, temperature: 30)
    }

    private func loadNotificationTable() throws {
        guard let tasks = try taskLoader.getTasks() else { return }
        self.interfaceModel.notificationsTable = .init(tasks: tasks)
    }

}
