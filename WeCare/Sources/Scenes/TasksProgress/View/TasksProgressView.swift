//
//  TasksProgressView.swift
//  WeCare
//
//  Created by Yago Marques on 26/02/23.
//

import Foundation
import UIKit

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
    }

}

extension TasksProgressView: ViewCoding {
    func setupView() {
        self.backgroundColor = UIColor(named: "backgroundColor")
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            halfCircle.topAnchor.constraint(equalToSystemSpacingBelow: safeAreaLayoutGuide.topAnchor, multiplier: 5),
            halfCircle.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            halfCircle.heightAnchor.constraint(equalTo: halfCircle.widthAnchor, multiplier: 0.5),
            halfCircle.centerXAnchor.constraint(equalTo: centerXAnchor),

            percentageLabel.centerXAnchor.constraint(equalTo: halfCircle.centerXAnchor),
            percentageLabel.centerYAnchor.constraint(equalTo: halfCircle.centerYAnchor, constant: 10),

            progressDescription.topAnchor.constraint(equalToSystemSpacingBelow: percentageLabel.bottomAnchor, multiplier: 1),
            progressDescription.widthAnchor.constraint(equalTo: halfCircle.widthAnchor, multiplier: 0.7),
            progressDescription.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    func setupHierarchy() {
        addSubview(halfCircle)
        addSubview(percentageLabel)
        addSubview(progressDescription)
    }
}
