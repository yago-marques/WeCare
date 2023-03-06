//
//  ProgressBar.swift
//  WeCare
//
//  Created by Yago Marques on 06/03/23.
//

import UIKit

final class ProgressBar: UIView {

    var viewModel: TasksProgressViewModel = .init(allTasksCount: 0, doneTasksCount: 0, doneTasks: []) {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.animateBar()
                self?.updateLabel()
            }
        }
    }

    private let barShape: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.cornerCurve = .circular
        view.layer.cornerRadius = 15
        view.layer.opacity = 0.2

        return view
    }()

    private let progressShape: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "progressColor")
        view.clipsToBounds = true
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        view.layer.cornerCurve = .circular
        view.layer.cornerRadius = 15

        return view
    }()

    private let progressLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true


        return label
    }()

    init() {
        super.init(frame: .zero)

        buildLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("error ProgressBar")
    }

    func animateBar() {
        UIView.transition(
            with: self.progressShape,
            duration: 0.7,
            options: .transitionCrossDissolve,
            animations: {
                self.progressShape.frame = CGRect(
                    x: 0,
                    y: 0,
                    width: self.frame.width * self.viewModel.getPercentageDouble(),
                    height: self.frame.height)
                self.layoutIfNeeded()
            }
        )
    }

    func updateLabel() {
        self.progressLabel.text = "\(viewModel.getPercentage()) - \(viewModel.getProgressDescription())"
        if self.viewModel.doneTasksCount > self.viewModel.allTasksCount - 2 {
            self.progressShape.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        }
    }

    func setup(viewModel: TasksProgressViewModel) {
        self.viewModel = viewModel
    }
}

extension ProgressBar: ViewCoding {
    func setupView() {
        self.backgroundColor = .clear
    }

    func setupHierarchy() {
        self.addSubview(barShape)
        self.addSubview(progressShape)
        self.addSubview(progressLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            barShape.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            barShape.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            barShape.widthAnchor.constraint(equalTo: self.widthAnchor),
            barShape.heightAnchor.constraint(equalTo: self.heightAnchor),

            progressLabel.centerXAnchor.constraint(equalTo: barShape.centerXAnchor),
            progressLabel.centerYAnchor.constraint(equalTo: barShape.centerYAnchor),
            progressLabel.widthAnchor.constraint(equalTo: barShape.widthAnchor, multiplier: 0.7),
            progressLabel.heightAnchor.constraint(equalTo: barShape.heightAnchor, multiplier: 0.95)
        ])
    }
}
