//
//  DailyTasksViewModel.swift
//  WeCare
//
//  Created by Yago Marques on 14/02/23.
//

import Foundation

struct DailyTasksViewModel {
    var header: HeaderGreetingsViewModel?
    var weatherCard: WeatherCardViewModel?
    var notificationsTable: NotificationsTasksViewModel?
}

extension DailyTasksViewModel {
    static func getMock() -> DailyTasksViewModel {
        .init(
            header: .init(userName: "Yago"),
            weatherCard: .init(
                weather: .init(
                    temperature: "29 °C",
                    uvIndex: 3,
                    city: "Fortaleza",
                    country: "Brasil",
                    weatherIcon: "sun"
                )
            ),

            notificationsTable: .init(tasks: [
                .init(
                    id: UUID(),
                    useCases: nil,
                    title: "Hidratante",
                    description: "Passar hidratante",
                    icon: "Default",
                    voiceIcon: "",
                    stepsDescription: "É só passar o hidratante",
                    steps:
                        [
                            .init(
                                title: "Abrir o hidratante",
                                description: "Gire a tampa até abrir"
                            ),
                            .init(
                                title: "Passar no rosto",
                                description: "Use movimemtos circulares"
                            )
                        ],
                    isDone: false,
                    hour: Date().getHour
                ),
                .init(
                    id: UUID(),
                    useCases: nil,
                    title: "Hidratante",
                    description: "Passar hidratante",
                    icon: "Default",
                    voiceIcon: "",
                    stepsDescription: "É só passar o hidratante",
                    steps:
                        [
                            .init(
                                title: "Abrir o hidratante",
                                description: "Gire a tampa até abrir"
                            ),
                            .init(
                                title: "Passar no rosto",
                                description: "Use movimemtos circulares"
                            )
                        ],
                    isDone: false,
                    hour: Date().getHour
                )
            ])
        )
    }
}
