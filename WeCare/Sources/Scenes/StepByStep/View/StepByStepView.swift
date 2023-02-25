//
//  StepByStepSheetView.swift
//  WeCare
//
//  Created by Emilly Maia on 13/02/23.
//

import Foundation
import UIKit



class StepByStepView: UIView {
    
    weak var delegate: DismissSheetDelegate?

    private let stepIcon: UIImageView = {
        let stepIcon = UIImageView()
        stepIcon.translatesAutoresizingMaskIntoConstraints = false
        stepIcon.contentMode = .scaleAspectFit
        return stepIcon
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .close)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        button.tag = 2
        button.clipsToBounds = true
        return button
    }()

    private let stepDescription: UILabel = {
        let stepDescription = UILabel()
        stepDescription.translatesAutoresizingMaskIntoConstraints = false
        stepDescription.numberOfLines = 0
        stepDescription.adjustsFontForContentSizeCategory = true
        stepDescription.font = UIFont.preferredFont(forTextStyle: .body)
        stepDescription.textAlignment = .center
        return stepDescription
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(named: "backgroundColor")
        tableView.separatorStyle = .none
        tableView.register(StepByStepViewCell.self, forCellReuseIdentifier: StepByStepViewCell.identifier)

        return tableView
    }()

    init() {
        super.init(frame: .zero)
        buildLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView(viewModel: NotificationsTask) {
        self.stepDescription.text = viewModel.stepsDescription
        self.stepIcon.image = UIImage(named: viewModel.icon)
    }
    
    @objc func closeAction(sender: UIButton) {
        delegate?.dismiss()
    }

}

extension StepByStepView: ViewCoding {
    func setupView() {
        self.backgroundColor = UIColor(named: "backgroundColor")
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),

            stepIcon.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 5),
            stepIcon.centerXAnchor.constraint(equalTo: centerXAnchor),
            stepIcon.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2),
            stepIcon.heightAnchor.constraint(equalTo: stepIcon.widthAnchor),

            stepDescription.topAnchor.constraint(equalToSystemSpacingBelow: stepIcon.bottomAnchor, multiplier: 3),
            stepDescription.centerXAnchor.constraint(equalTo: centerXAnchor),
            stepDescription.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),


            tableView.topAnchor.constraint(equalToSystemSpacingBelow: stepDescription.bottomAnchor, multiplier: 2),
            tableView.widthAnchor.constraint(equalTo: widthAnchor),
            tableView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8)

        ])
    }

    func setupHierarchy() {
        addSubview(closeButton)
        addSubview(stepIcon)
        addSubview(stepDescription)
        addSubview(tableView)
    }

}
