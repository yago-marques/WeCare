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
        self.navigationItem.title = "Seu progresso"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        tasksProgressView.tableView.delegate = self
        tasksProgressView.tableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tasksProgressView.setup(viewModel: self.viewModel)
    }
}

extension TasksProgressController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = viewModel.doneTasksCount
        if rows == 0 {
            tasksProgressView.addEmptyTableAnimation()
            return 0
        } else {
            return rows
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else {
            return UITableViewCell()
        }

        let viewModel = viewModel.doneTasks[indexPath.row]

        cell.textLabel?.text = "\(viewModel.title) às \(viewModel.getHour())"
        cell.backgroundColor = .white
        cell.textLabel?.textColor = .black

        return cell
    }
}

extension TasksProgressController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Cuidados feitos:"
    }
}
