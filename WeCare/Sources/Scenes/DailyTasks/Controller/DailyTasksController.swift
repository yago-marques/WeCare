//
//  DailyTasksController.swift
//  WeCare
//
//  Created by Yago Marques on 13/02/23.
//

import Foundation
import UIKit

final class DailyTasksController: UIViewController {

    let dailyView: DailyTasksView
    let presenter: DailyTasksPresenting

    init(dailyView: DailyTasksView, presenter: DailyTasksPresenting) {
        self.dailyView = dailyView
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    override func viewDidLoad() {
        super.viewDidLoad()

        dailyView.setupController(controller: self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        Task {
            do {
                try await presenter.showView(self)
            } catch {
                print(error)
            }
        }
    }

    func toShhet() {
        navigationController?.present(StepByStepViewController(), animated: true)
    }
    
}
