//
//  TasksProgressView.swift
//  WeCare
//
//  Created by Yago Marques on 26/02/23.
//

import Foundation
import UIKit
import Lottie

final class TasksProgressView: UIView {

    private lazy var halfCircle: HalfCircleProgress = {
        let progress = HalfCircleProgress(isInnerCircleExist: true)
        progress.translatesAutoresizingMaskIntoConstraints = false
        let width = self.frame.width*0.8
        progress.drawShape(bounds: CGRect(x: 0, y: 0, width: width, height: width/2))

        return progress
    }()

    private let percentageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)

        return label
    }()

    private let progressDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)

        return label
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        return tableView
    }()

    let emptyTasksAnimation: LottieAnimationView = {
        let animationView = LottieAnimationView(animation: LottieAnimation.named("empty-notifications"))
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.backgroundColor = .clear
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop

        return animationView
    }()

    let emptyTasksLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Você não possui cuidados concluídos!"
        label.textColor = .secondaryLabel

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    func setup(viewModel: TasksProgressViewModel) {
        self.halfCircle.updateProgress(percent: viewModel.getPercentageDouble())
        self.percentageLabel.text = viewModel.getPercentage()
        self.progressDescription.text = viewModel.getProgressDescription()
        accessibility()
    }

    func addEmptyTableAnimation() {
        self.addSubview(emptyTasksAnimation)
        self.addSubview(emptyTasksLabel)

        NSLayoutConstraint.activate([
            emptyTasksAnimation.topAnchor.constraint(equalToSystemSpacingBelow: tableView.topAnchor, multiplier: 4),
            emptyTasksAnimation.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyTasksAnimation.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            emptyTasksAnimation.heightAnchor.constraint(equalTo: emptyTasksAnimation.widthAnchor),

            emptyTasksLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyTasksLabel.topAnchor.constraint(equalToSystemSpacingBelow: emptyTasksAnimation.bottomAnchor, multiplier: 1)
        ])

        emptyTasksAnimation.play()
    }

}

extension TasksProgressView: ViewCoding {
    func setupView() {
        self.backgroundColor = UIColor(named: "backgroundColor")
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            halfCircle.topAnchor.constraint(equalToSystemSpacingBelow: safeAreaLayoutGuide.topAnchor, multiplier: 3),
            halfCircle.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            halfCircle.heightAnchor.constraint(equalTo: halfCircle.widthAnchor, multiplier: 0.5),
            halfCircle.centerXAnchor.constraint(equalTo: centerXAnchor),

            percentageLabel.centerXAnchor.constraint(equalTo: halfCircle.centerXAnchor),
            percentageLabel.centerYAnchor.constraint(equalTo: halfCircle.centerYAnchor, constant: 10),

            progressDescription.topAnchor.constraint(equalToSystemSpacingBelow: percentageLabel.bottomAnchor, multiplier: 1),
            progressDescription.widthAnchor.constraint(equalTo: halfCircle.widthAnchor, multiplier: 0.7),
            progressDescription.centerXAnchor.constraint(equalTo: centerXAnchor),

            tableView.widthAnchor.constraint(equalTo: widthAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            tableView.topAnchor.constraint(equalToSystemSpacingBelow: halfCircle.bottomAnchor, multiplier: 2)
        ])
    }

    func setupHierarchy() {
        addSubview(halfCircle)
        addSubview(percentageLabel)
        addSubview(progressDescription)
        addSubview(tableView)
    }
}

extension TasksProgressView {
    func accessibility() {
        progressDescription.isAccessibilityElement = false
        percentageLabel.isAccessibilityElement = false
        halfCircle.isAccessibilityElement = true

        halfCircle.accessibilityLabel = "Porcentagem de tarefas concluídas, \((percentageLabel.text ?? "erro")). Número de tarefas concluídas \((progressDescription.text ?? "erro"))"
    }
}
