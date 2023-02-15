//
//  NotificationsTaskExtension.swift
//  WeCare
//
//  Created by Yago Marques on 15/02/23.
//

import Foundation

extension NotificationsTask {
    static func getUseCases() -> [NotificationsTask] {
        [
            .init(
                useCases: .init(
                    minTemperature: 25,
                    minUvIndex: 3,
                    maxTemperature: 100,
                    maxUvIndex: 20
                ),
                title: "Protetor solar",
                description: "",
                icon: "",
                steps: getSolarProtectorSteps()
            ),

            .init(
                useCases: .init(
                    minTemperature: -20,
                    minUvIndex: 0,
                    maxTemperature: 22,
                    maxUvIndex: 20
                ),
                title: "Hidratante",
                description: "",
                icon: "",
                steps: getHidratationSteps()
            ),

            .init(
                useCases: .init(
                    minTemperature: 30,
                    minUvIndex: 4,
                    maxTemperature: 100,
                    maxUvIndex: 20
                ),
                title: "Acessórios",
                description: "",
                icon: "",
                steps: (
                    "Que tal proteger ainda mais a pele desse sol com acessórios?🥵",
                    [
                        .init(
                            title: "Passo 01:",
                            description: "Escolha acessórios estilosos para seu look e que protegem sua pele, como chapéus, óculos e até sombrinhas"
                        )
                    ]
                )
            )
        ]
    }

    static func getMorningTasks() -> [NotificationsTask] {
        [
            .init(
                useCases: nil,
                title: "Lavar o rosto",
                description: "",
                icon: "",
                steps: getWashFaceSteps()
            ),

            .init(
                useCases: nil,
                title: "Hidratante",
                description: "",
                icon: "",
                steps: getHidratationSteps()
            ),

            .init(
                useCases: nil,
                title: "Protetor solar",
                description: "",
                icon: "",
                steps: getSolarProtectorSteps()
            )
        ]
    }

    static func getEveningTasks() -> [NotificationsTask] {
        [
            .init(
                useCases: nil,
                title: "Lavar o rosto",
                description: "",
                icon: "",
                steps: getWashFaceSteps()
            ),

            .init(
                useCases: nil,
                title: "Hidratante",
                description: "",
                icon: "",
                steps: getHidratationSteps()
            ),
        ]
    }

    static func getHidratationSteps() -> (String, [TaskStep]) {
        (
            "Em dias frios e secos a hidratação é essencial para a saúde da pele.",
            [
                .init(
                    title: "Passo 01:",
                    description: "Aplique seu produtinho preferido de hidratacão (hidratante facial, sérun, loção..) delicadamente no rosto e espalhe bem"
                ),
                .init(
                    title: "Passo 02:",
                    description: "Depois finalize com um bom protetor labial"
                )
            ]
        )
    }

    static func getSolarProtectorSteps() -> (String, [TaskStep]) {
        (
            "Os raios UVA e UVB ainda alcançam sua pele, que tal um filtro solar?",
            [
                .init(
                    title: "Passo 01:",
                    description: "Aplique seu filtro solar facial por todo o rosto e espalhe bem. Não esqueça o pescoço!"
                ),
            ]
        )
    }

    static func getWashFaceSteps() -> (String, [TaskStep]) {
        (
            "amos fazer uma limpeza nesse rostinho?",
            [
                .init(
                    title: "Passo 01:",
                    description: "Enxágue seu rosto com água"
                ),
                .init(
                    title: "Passo 02:",
                    description: "Aplique o sabonete facial (líquido, em barra..) e espalhe de forma circular com as mãos ou com algum item que exerça essa função"
                ),
                .init(
                    title: "Passo 03:",
                    description: "Depois retire bem o produto do rosto com água e está pronta essa limpeza!"
                )
            ]
        )
    }

}
