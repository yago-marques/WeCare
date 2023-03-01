//
//  DailyTasksView.swift
//  WeCare
//
//  Created by Yago Marques on 13/02/23.
//

import Foundation
import UIKit
import Lottie

final class DailyTasksView: UIView {

    var notificationsViewModel: NotificationsTasksViewModel? {
        didSet {
            self.notificationsTable.tableView.reloadData()
        }
    }
    weak var controller: DailyTasksController?

    lazy var weatherAnimationLoader: LottieAnimationView = {
        let animationView = LottieAnimationView(animation: LottieAnimation.named("loader"))
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.backgroundColor = .clear
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop

        return animationView
    }()

    lazy var emptyTasksAnimation: LottieAnimationView = {
        let animationView = LottieAnimationView(animation: LottieAnimation.named("empty-notifications"))
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.backgroundColor = .clear
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop

        return animationView
    }()

    private let emptyTasksLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Você não possui cuidados pendentes!"
        label.textColor = .secondaryLabel

        return label
    }()

    private let weatherCard: WeatherCardView = {
        let card = WeatherCardView()
        card.translatesAutoresizingMaskIntoConstraints = false

        return card
    }()

    private let tableLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Cuidados pendentes:"
        label.font = UIFont.preferredFont(forTextStyle: .title2)

        return label
    }()

    lazy var notificationsTable: NotificationsTableView = {
        let table = NotificationsTableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.tableView.delegate = self
        table.tableView.dataSource = self

        return table
    }()
    
    lazy var background: UIImageView = {
        let background = UIImageView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.contentMode = .scaleAspectFill
        background.image = UIImage(named: "DailyTasksBackground")
        return background
    }()

    init(frame: CGRect, controller: DailyTasksController? = nil) {
        self.controller = controller
        super.init(frame: frame)
        buildLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    func setup(viewModel: DailyTasksViewModel) {
        self.weatherCard.setup(viewModel: viewModel.weatherCard)
        self.notificationsViewModel = viewModel.notificationsTable
    }

    func setupController(controller: DailyTasksController) {
        self.controller = controller
    }

    func addEmptyTableAnimation() {
        self.addSubview(emptyTasksAnimation)
        self.addSubview(emptyTasksLabel)

        NSLayoutConstraint.activate([
            emptyTasksAnimation.topAnchor.constraint(equalTo: notificationsTable.topAnchor),
            emptyTasksAnimation.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyTasksAnimation.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            emptyTasksAnimation.heightAnchor.constraint(equalTo: emptyTasksAnimation.widthAnchor),

            emptyTasksLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyTasksLabel.topAnchor.constraint(equalToSystemSpacingBelow: emptyTasksAnimation.bottomAnchor, multiplier: 1)
        ])

        emptyTasksAnimation.play()
    }
}

extension DailyTasksView: UITableViewDelegate { }

extension DailyTasksView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = self.notificationsViewModel?.tasks.count else { return 0 }

        if count == 0 {
            addEmptyTableAnimation()
            return 0
        } else {
            return count
        }
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
        updatedAction.backgroundColor = UIColor(red: 0.55, green: 0.6, blue: 0.27, alpha: 1)
        let swipeAction = UISwipeActionsConfiguration(actions: [updatedAction])
        return swipeAction
    }

}

extension DailyTasksView: ViewCoding {
    func setupView() {
        self.backgroundColor = UIColor(named: "backgroundColor")
        weatherAnimationLoader.play()
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: topAnchor),
            background.widthAnchor.constraint(equalTo: widthAnchor),
            background.heightAnchor.constraint(equalTo: heightAnchor),
            background.bottomAnchor.constraint(equalTo: bottomAnchor),

            weatherCard.topAnchor.constraint(equalTo: topAnchor, constant: -40),
            weatherCard.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.98),
            weatherCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -30),
            weatherCard.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 30),

            tableLabel.topAnchor.constraint(equalToSystemSpacingBelow: weatherCard.bottomAnchor, multiplier: 1),
            tableLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            notificationsTable.topAnchor.constraint(equalToSystemSpacingBelow: tableLabel.bottomAnchor, multiplier: 1),
            notificationsTable.widthAnchor.constraint(equalTo: self.widthAnchor),
            notificationsTable.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),

            weatherAnimationLoader.centerXAnchor.constraint(equalTo: weatherCard.centerXAnchor),
            weatherAnimationLoader.centerYAnchor.constraint(equalTo: weatherCard.centerYAnchor),
            weatherAnimationLoader.widthAnchor.constraint(equalTo: weatherCard.widthAnchor, multiplier: 0.7),
            weatherAnimationLoader.heightAnchor.constraint(equalTo: weatherAnimationLoader.widthAnchor),
        ])
    }

    func setupHierarchy() {
        let views = [
            background,
            weatherCard,
            notificationsTable,
            weatherAnimationLoader,
            tableLabel
        ]

        views.forEach { view in
            self.addSubview(view)
        }
    }
}
