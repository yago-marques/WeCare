//
//  StepByStepViewCell.swift
//  WeCare
//
//  Created by Emilly Maia on 14/02/23.
//

import Foundation
import UIKit

class StepByStepViewCell: UITableViewCell {
    
    static let identifier = "StepByStepViewCell"
    
    private lazy var cell: UIView = {
        let cell = UIView()
        cell.translatesAutoresizingMaskIntoConstraints = false
        return cell
    }()
    
    private lazy var titleStep: UILabel = {
        let titleStep = UILabel()
        titleStep.translatesAutoresizingMaskIntoConstraints = false
        titleStep.adjustsFontForContentSizeCategory = true
        titleStep.font = UIFont.preferredFont(forTextStyle: .title3)
        titleStep.numberOfLines = 0
        titleStep.text = "Passo 1"
        return titleStep
    }()
    
    private lazy var descriptionStep: UILabel = {
        let descriptionStep = UILabel()
        descriptionStep.translatesAutoresizingMaskIntoConstraints = false
        descriptionStep.adjustsFontForContentSizeCategory = true
        descriptionStep.font = UIFont.preferredFont(forTextStyle: .title3)
        descriptionStep.numberOfLines = 0
        descriptionStep.text = "Aplique uma quantidade X de produto tanto no rosto quanto no pescoço, para garantir hidratação"
        return descriptionStep
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StepByStepViewCell {
    func configureCellInformations(title: String, description: String) {
        titleStep.text = title
        descriptionStep.text = title
    }
}

extension StepByStepViewCell: ViewCoding {
    func setupView() {
        self.selectionStyle = .none
        self.backgroundColor = .systemBackground
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            cell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            cell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            cell.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            cell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            
            titleStep.topAnchor.constraint(equalTo: cell.topAnchor, constant: 4),
            titleStep.widthAnchor.constraint(equalTo: cell.widthAnchor, multiplier: 8),
            titleStep.leadingAnchor.constraint(equalTo: cell.leadingAnchor),
            
            
            descriptionStep.topAnchor.constraint(equalToSystemSpacingBelow: titleStep.bottomAnchor, multiplier: 0.2),
            descriptionStep.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -8),
            descriptionStep.leadingAnchor.constraint(equalTo: titleStep.leadingAnchor),
            descriptionStep.trailingAnchor.constraint(equalTo: cell.trailingAnchor)
            
        ])
    }
    
    func setupHierarchy() {
        addSubview(cell)
        cell.addSubview(titleStep)
        cell.addSubview(descriptionStep)
    }
    
    
}
