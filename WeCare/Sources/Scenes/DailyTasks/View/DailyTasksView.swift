//
//  DailyTasksView.swift
//  WeCare
//
//  Created by Yago Marques on 13/02/23.
//

import Foundation
import UIKit

final class DailyTasksView: UIView {

    var notificationsViewModel: NotificationsTasksViewModel? {
        didSet {
            self.notificationsTable.tableView.reloadData()
        }
    }
    weak var controller: DailyTasksController?

    private let headerGreetings: HeaderGreetings = {
        let header = HeaderGreetings()
        header.translatesAutoresizingMaskIntoConstraints = false

        return header
    }()

    private let weatherCard: WeatherCardView = {
        let card = WeatherCardView()
        card.translatesAutoresizingMaskIntoConstraints = false

        return card
    }()

    lazy var notificationsTable: NotificationsTableView = {
        let table = NotificationsTableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.tableView.delegate = self
        table.tableView.dataSource = self

        return table
    }()

    init(frame: CGRect, controller: DailyTasksController? = nil) {
        self.controller = controller
        super.init(frame: frame)
        buildLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    func setup(viewModel: DailyTasksViewModel) {
        self.headerGreetings.setup(viewModel: viewModel.header)
        self.weatherCard.setup(viewModel: viewModel.weatherCard)
        self.notificationsViewModel = viewModel.notificationsTable
    }

    func setupController(controller: DailyTasksController) {
        self.controller = controller
    }
}

extension DailyTasksView: UITableViewDelegate { }

extension DailyTasksView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.notificationsViewModel?.tasks.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: NotificationViewCell.identifier, for: indexPath) as? NotificationViewCell else {
            return UITableViewCell(style: .default, reuseIdentifier: NotificationViewCell.identifier)
        }

        if let viewModel = self.notificationsViewModel?.tasks[indexPath.row] {
            cell.setup(viewModel: viewModel)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = notificationsViewModel?.tasks[indexPath.row] else { return }
        controller?.openSheet(viewModel: viewModel)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let updatedAction = UIContextualAction(style: .destructive, title: "Feito") {_,_,completionHandler in
            guard let taskId = self.notificationsViewModel?.tasks[indexPath.row].id else { return }
            try? self.controller?.markTaskAsDone(id: taskId)
            completionHandler(true)
        }
        updatedAction.image = UIImage(systemName: "checkmark.diamond.fill")
        updatedAction.backgroundColor = .systemGreen
        let swipeAction = UISwipeActionsConfiguration(actions: [updatedAction])
        return swipeAction
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Cuidados Pendentes"
    }
        

}

extension DailyTasksView: ViewCoding {
    func setupView() {
        self.backgroundColor = UIColor(named: "backgroundColor")
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            headerGreetings.topAnchor.constraint(equalTo: self.topAnchor),
            headerGreetings.widthAnchor.constraint(equalTo: self.widthAnchor),
            headerGreetings.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            headerGreetings.heightAnchor.constraint(equalTo: headerGreetings.widthAnchor, multiplier: 0.4),

            weatherCard.topAnchor.constraint(equalToSystemSpacingBelow: headerGreetings.bottomAnchor, multiplier: 1),
            weatherCard.widthAnchor.constraint(equalTo: self.widthAnchor),
            weatherCard.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6),

            notificationsTable.topAnchor.constraint(equalToSystemSpacingBelow: weatherCard.bottomAnchor, multiplier: 0.1),
            notificationsTable.widthAnchor.constraint(equalTo: self.widthAnchor),
            notificationsTable.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func setupHierarchy() {
        let views = [
            headerGreetings,
            weatherCard,
            notificationsTable
        ]

        views.forEach { view in
            self.addSubview(view)
        }
    }
}
