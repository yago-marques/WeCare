//
//  StepByStepSheetView.swift
//  WeCare
//
//  Created by Emilly Maia on 13/02/23.
//

import Foundation
import UIKit

class StepByStepView: UIView {
    
    internal lazy var stepIcon: UIImageView = {
        let stepIcon = UIImageView()
        stepIcon.translatesAutoresizingMaskIntoConstraints = false
        stepIcon.image = UIImage(systemName: "sun.max.fill")
        return stepIcon
    }()
    
    internal lazy var stepDescription: UILabel = {
        let stepDescription = UILabel()
        stepDescription.translatesAutoresizingMaskIntoConstraints = false
        stepDescription.numberOfLines = 0
        stepDescription.adjustsFontForContentSizeCategory = true
        stepDescription.font = UIFont.preferredFont(forTextStyle: .caption2)
        stepDescription.text = "Que tal passar protetor para proteger esse rostinho? 🥵"
        return stepDescription
    }()
    
    internal lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemBackground
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
}

extension StepByStepView: ViewCoding {
    func setupView() { }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            stepIcon.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            stepIcon.centerXAnchor.constraint(equalTo: centerXAnchor),
            stepIcon.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2),
            stepIcon.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1),
            stepIcon.bottomAnchor.constraint(equalTo: tableView.topAnchor),
            
            tableView.topAnchor.constraint(equalTo: stepIcon.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)

        ])
    }
    
    func setupHierarchy() {
        addSubview(stepIcon)
        addSubview(tableView)
       // addSubview(stepDescription)
    }
    
    
}
