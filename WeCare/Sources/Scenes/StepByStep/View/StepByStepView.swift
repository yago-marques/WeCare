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
    weak var controller: StepByStepViewController?
    var id: UUID? = nil

    private let stepIcon: UIImageView = {
        let stepIcon = UIImageView()
        stepIcon.translatesAutoresizingMaskIntoConstraints = false
        stepIcon.contentMode = .scaleAspectFit
        return stepIcon
    }()

    private let voiceIcon: UILabel = {
        var voiceIcon = UILabel()
        return voiceIcon
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .close)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        button.tag = 2
        button.clipsToBounds = true
        button.accessibilityLabel = "Fechar aba"
        return button
    }()

    private let stepDescription: UILabel = {
        let stepDescription = UILabel()
        stepDescription.translatesAutoresizingMaskIntoConstraints = false
        stepDescription.numberOfLines = 0
        stepDescription.font = UIFont.preferredFont(forTextStyle: .callout)
        stepDescription.textAlignment = .left
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
     
    private lazy var doneButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .systemBackground
        button.backgroundColor = .systemRed
        button.layer.cornerCurve = .circular
        button.layer.cornerRadius = 10
        button.setTitle("Feito", for: .normal)
        button.backgroundColor = UIColor(named: "ActionButtonColor")
        button.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
        return button
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
        self.voiceIcon.text = viewModel.voiceIcon
        self.id = viewModel.id
        stepDescriptionAccesible()
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


            tableView.topAnchor.constraint(equalToSystemSpacingBelow: stepDescription.bottomAnchor, multiplier: 5),
            tableView.widthAnchor.constraint(equalTo: widthAnchor),
            tableView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            
            doneButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 40),
            doneButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            doneButton.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.1),
            doneButton.centerXAnchor.constraint(equalTo: stepIcon.centerXAnchor),

            

        ])
    }

    func setupHierarchy() {
        addSubview(closeButton)
        addSubview(stepIcon)
        addSubview(stepDescription)
        addSubview(tableView)
        addSubview(doneButton)
    }

}

extension StepByStepView {
    
    @objc func closeAction(sender: UIButton) {
        delegate?.dismiss()
    }
    
    @objc func doneButtonPressed() {
        guard let id = self.id else { return }
        try? controller?.dailyController.markTaskAsDone(id: id)
        delegate?.dismiss()
    }
    
    func stepDescriptionAccesible() {
        self.stepDescription.accessibilityLabel = "resumo da etapa de cuidados: \(stepDescription.text ?? "vazio")"
        self.stepIcon.isAccessibilityElement = true
        stepIcon.accessibilityLabel = "\(voiceIcon.text ?? "erro")"
    }

}
