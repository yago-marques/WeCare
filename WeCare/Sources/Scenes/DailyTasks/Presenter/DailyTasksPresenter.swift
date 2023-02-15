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

    var interfaceModel = DailyTasksViewModel()

    init(controller: DailyTasksController? = nil, weatherService: WeatherClient) {
        self.controller = controller
        self.weatherService = weatherService
    }
}

extension DailyTasksPresenter: DailyTasksPresenting {
    func showView(_ controller: DailyTasksController) async throws {
        self.controller = controller
        do {
            incrementView()
            loadHeader()
            try await loadWeatherCard()
            loadNotificationTable()
            updateInterface()
        } catch {
            throw error
        }
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
        }
    }

    private func loadHeader() {
        self.interfaceModel.header = .init(userName: "Yago")
    }

    private func loadWeatherCard() async throws {
        self.interfaceModel.weatherCard = DailyTasksViewModel.getMock().weatherCard
//        do {
//            let weather = try await weatherService.getWeather()
//            self.interfaceModel.weatherCard = .init(weather: weather)
//        } catch {
//            throw error
//        }
    }

    private func loadNotificationTable() {
        self.interfaceModel.notificationsTable = DailyTasksViewModel.getMock().notificationsTable
    }
}
