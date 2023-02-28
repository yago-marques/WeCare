//
//  TasksProgressController.swift
//  WeCare
//
//  Created by Yago Marques on 26/02/23.
//

import Foundation
import UIKit

final class TasksProgressController: UIViewController {
    private let tasksProgressView: TasksProgressView
    private let viewModel: TasksProgressViewModel

    init(
        tasksProgressView: TasksProgressView,
        viewModel: TasksProgressViewModel
    ) {
        self.tasksProgressView = tasksProgressView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view = self.tasksProgressView
        self.title = "Seu progresso"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tasksProgressView.setup(viewModel: self.viewModel)
    }
}
