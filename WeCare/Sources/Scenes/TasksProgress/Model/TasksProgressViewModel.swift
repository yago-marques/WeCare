//
//  TaskProgressViewModel.swift
//  WeCare
//
//  Created by Yago Marques on 26/02/23.
//

import Foundation

struct TasksProgressViewModel {
    let allTaksCount: Int
    let doneTasksCount: Int
    let doneTasks: [NotificationsTask]

    func getPercentageDouble() -> Double {
        if allTaksCount == 0 {
            return Double(allTaksCount)
        } else {
            return Double(doneTasksCount)/Double(allTaksCount)
        }

    }

    func getPercentage() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.minimumIntegerDigits = 1
        formatter.maximumIntegerDigits = 3
        formatter.maximumFractionDigits = 2

        formatter.locale = Locale(identifier: "pt_BR")
        let floatDivision = allTaksCount == 0 ? 0 : Double(doneTasksCount)/Double(allTaksCount)
        guard let percentage = formatter.string(
            from: NSDecimalNumber(decimal: Decimal(floatDivision))
        ) else { return "inválido" }

        return percentage
    }

    func getProgressDescription() -> String {
        "\(doneTasksCount) de \(allTaksCount)"
    }
}
