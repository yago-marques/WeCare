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
        titleStep.font = UIFont.preferredFont(forTextStyle: .headline)
        titleStep.numberOfLines = 0
        return titleStep
    }()

    private let wayPoint: UIView = {
        let point = UIView()
        point.translatesAutoresizingMaskIntoConstraints = false
        point.clipsToBounds = true
        point.layer.cornerCurve = .circular
        point.layer.cornerRadius = 10
        point.backgroundColor = UIColor(named: "NotificationCellColor")

        return point
    }()

    private let wayRoute: UIView = {
        let route = UIView()
        route.translatesAutoresizingMaskIntoConstraints = false
        route.backgroundColor = UIColor(named: "NotificationCellColor")

        return route
    }()

    private lazy var descriptionStep: UILabel = {
        let descriptionStep = UILabel()
        descriptionStep.translatesAutoresizingMaskIntoConstraints = false
        descriptionStep.adjustsFontForContentSizeCategory = true
        descriptionStep.font = UIFont.preferredFont(forTextStyle: .subheadline)
        descriptionStep.numberOfLines = 0
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
    func configureCellInformations(title: String, description: String, isLast: Bool) {
        titleStep.text = title
        descriptionStep.text = description
        if !isLast {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.addRouteIfNeeded()
            }
        }
    }

    func addRouteIfNeeded() {
        self.addSubview(wayRoute)

        NSLayoutConstraint.activate([
            wayRoute.topAnchor.constraint(equalTo: wayPoint.centerYAnchor),
            wayRoute.widthAnchor.constraint(equalToConstant: 1),
            wayRoute.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 2),
            wayRoute.centerXAnchor.constraint(equalTo: wayPoint.centerXAnchor)
        ])
    }
}

extension StepByStepViewCell: ViewCoding {
    func setupView() {
        self.selectionStyle = .none
        self.backgroundColor = UIColor(named: "backgroundColor")
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            cell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            cell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            cell.topAnchor.constraint(equalTo: topAnchor),
            cell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),

            wayPoint.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            wayPoint.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            wayPoint.widthAnchor.constraint(equalToConstant: 20),
            wayPoint.heightAnchor.constraint(equalTo: wayPoint.widthAnchor),

            titleStep.topAnchor.constraint(equalTo: cell.topAnchor),
            titleStep.widthAnchor.constraint(equalTo: cell.widthAnchor, multiplier: 8),
            titleStep.leadingAnchor.constraint(equalTo: wayPoint.trailingAnchor, constant: 20),


            descriptionStep.topAnchor.constraint(equalToSystemSpacingBelow: titleStep.bottomAnchor, multiplier: 0.2),
            descriptionStep.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -8),
            descriptionStep.leadingAnchor.constraint(equalTo: titleStep.leadingAnchor),
            descriptionStep.trailingAnchor.constraint(equalTo: cell.trailingAnchor)

        ])
    }

    func setupHierarchy() {
        addSubview(cell)
        cell.addSubview(wayPoint)
        cell.addSubview(titleStep)
        cell.addSubview(descriptionStep)
    }

}
