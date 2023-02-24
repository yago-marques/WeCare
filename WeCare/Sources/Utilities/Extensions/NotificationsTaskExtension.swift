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
                id: UUID(),
                useCases: .init(
                    minTemperature: 25,
                    minUvIndex: 3,
                    maxTemperature: 100,
                    maxUvIndex: 20
                ),
                title: "Protetor solar",
                description: "Os raios UVA e UVB ainda alcançam sua pele, que tal um filtro solar?",
                icon: "ProtecaoSolar",
                voiceIcon: "",
                stepsDescription: "O filtro solar ou protetor solar é uma loção, spray ou produto tópico que ajuda a proteger a pele da radiação ultravioleta do sol, o que reduz as queimaduras solares e outros danos à pele, intimamente ligado a um menor risco de câncer de pele.",
                steps: getSolarProtectorSteps(),
                isDone: false,
                hour: Date().getHour
            ),

                .init(
                    id: UUID(),
                    useCases: .init(
                        minTemperature: -20,
                        minUvIndex: 0,
                        maxTemperature: 22,
                        maxUvIndex: 20
                    ),
                    title: "Hidratante",
                    description: "Em dias frios e secos a hidratação é essencial para a saúde da pele.",
                    icon: "Hidratante",
                    voiceIcon: "",
                    stepsDescription: "O hidratante facial é um dermocosmético que tem como principal função “repor a água” da pele do rosto, mantendo assim a barreira cutânea protegida e a textura da pele sedosa e saudável, sem oleosidade excessiva ou sensação de ressecamento.",
                    steps: getHidratationSteps(),
                    isDone: false,
                    hour: Date().getHour
                ),

                .init(
                    id: UUID(),
                    useCases: .init(
                        minTemperature: 30,
                        minUvIndex: 4,
                        maxTemperature: 100,
                        maxUvIndex: 20
                    ),
                    title: "Acessórios",
                    description: "Cuidado com os raios UV! Vamos proteger a pele?",
                    icon: "Acessorios",
                    voiceIcon: "",
                    stepsDescription: "Para os dias quentes, o boné e óculos são perfeitos para dar estilo e proteger o rosto do sol",
                    steps:
                        [
                            .init(
                                title: "Passo 01:",
                                description: "Escolha acessórios estilosos para seu look e que protegem sua pele, como chapéus, óculos e até sombrinhas"
                            )
                        ],
                    isDone: false,
                    hour: Date().getHour
                )
        ]
    }

    static func getMorningTasks() -> [NotificationsTask] {
        [
            .init(
                id: UUID(),
                useCases: nil,
                title: "Lavar o rosto",
                description: "Vamos fazer uma limpeza nesse rostinho?",
                icon: "Limpeza",
                voiceIcon: "",
                stepsDescription: "Ter uma pele limpa é fundamental para que ela continue saudável e receba todos os benefícios do que você vai aplicar em seguida. Além disso, limpar seu rosto vai evitar poros entupidos (leia-se cravos e espinhas), normalizar sua produção de sebo e te ajudar a manter a pele viçosa.",
                steps: getWashFaceSteps(),
                isDone: false,
                hour: Date().getHour
            ),

                .init(
                    id: UUID(),
                    useCases: nil,
                    title: "Hidratante",
                    description: "Em dias frios e secos a hidratação é essencial para a saúde da pele.",
                    icon: "Hidratante",
                    voiceIcon: "",
                    stepsDescription: "O hidratante facial é um dermocosmético que tem como principal função “repor a água” da pele do rosto, mantendo assim a barreira cutânea protegida e a textura da pele sedosa e saudável, sem oleosidade excessiva ou sensação de ressecamento.",
                    steps: getHidratationSteps(),
                    isDone: false,
                    hour: Date().getHour
                ),

                .init(
                    id: UUID(),
                    useCases: nil,
                    title: "Protetor solar",
                    description: "Os raios UVA e UVB ainda alcançam sua pele, que tal um filtro solar?",
                    icon: "ProtecaoSolar",
                    voiceIcon: "",
                    stepsDescription: "O filtro solar ou protetor solar é uma loção, spray ou produto tópico que ajuda a proteger a pele da radiação ultravioleta do sol, o que reduz as queimaduras solares e outros danos à pele, intimamente ligado a um menor risco de câncer de pele.",
                    steps: getSolarProtectorSteps(),
                    isDone: false,
                    hour: Date().getHour
                )
        ]
    }

    static func getEveningTasks() -> [NotificationsTask] {
        [
            .init(
                id: UUID(),
                useCases: nil,
                title: "Lavar o rosto",
                description: "Vamos fazer uma limpeza nesse rostinho?",
                icon: "Limpeza",
                voiceIcon: "",
                stepsDescription: "Ter uma pele limpa é fundamental para que ela continue saudável e receba todos os benefícios do que você vai aplicar em seguida. Além disso, limpar seu rosto vai evitar poros entupidos (leia-se cravos e espinhas), normalizar sua produção de sebo e te ajudar a manter a pele viçosa.",
                steps: getWashFaceSteps(),
                isDone: false,
                hour: Date().getHour
            ),

                .init(
                    id: UUID(),
                    useCases: nil,
                    title: "Hidratante",
                    description: "Em dias frios e secos a hidratação é essencial para a saúde da pele.",
                    icon: "Hidratante",
                    voiceIcon: "",
                    stepsDescription: "O hidratante facial é um dermocosmético que tem como principal função “repor a água” da pele do rosto, mantendo assim a barreira cutânea protegida e a textura da pele sedosa e saudável, sem oleosidade excessiva ou sensação de ressecamento.",
                    steps: getHidratationSteps(),
                    isDone: false,
                    hour: Date().getHour
                ),
        ]
    }

    static func getHidratationSteps() -> [TaskStep] {
        (
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

    static func getSolarProtectorSteps() -> [TaskStep] {

        [
            .init(
                title: "Passo 01:",
                description: "Aplique seu filtro solar facial por todo o rosto e espalhe bem. Não esqueça o pescoço!"
            ),
        ]

    }

    static func getWashFaceSteps() -> [TaskStep] {
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
    }
    
    static func getUseAcessoriesSteps() -> [TaskStep] {
        [
            .init(
                title: "Faça já:",
                description: "Para os dias quentes, o boné e óculos são perfeitos para dar estilo e proteger o rosto do sol"
            ),
        ]

    }

}
