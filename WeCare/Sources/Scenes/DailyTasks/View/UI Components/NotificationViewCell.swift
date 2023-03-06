//
//  NotificationViewCell.swift
//  WeCare
//
//  Created by Emilly Maia on 10/02/23.

import Foundation
import UIKit

class NotificationViewCell: UITableViewCell {
    
    static let identifier = "NotificationViewCell"
    
    private lazy var cell: UIView = {
        let cell = UIView()
        cell.translatesAutoresizingMaskIntoConstraints = false
        cell.backgroundColor = UIColor(named: "NotificationCellColor")
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSizeMake(2.5, 2.5)
        cell.layer.shadowRadius = 0.9
        cell.layer.shadowOpacity = 0.2
        cell.layer.cornerCurve = .circular
        cell.layer.cornerRadius = 13
        return cell
    }()
    
    private lazy var imageCell: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var titleCell: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 0
        title.adjustsFontForContentSizeCategory = true
        title.font = UIFont.preferredFont(forTextStyle: .headline)
        return title
    }()
    
    private lazy var descriptionCell: UILabel = {
        let description = UILabel()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.numberOfLines = 0
        description.adjustsFontForContentSizeCategory = true
        description.font = UIFont.preferredFont(forTextStyle: .subheadline)
//        description.isAccessibilityElement = true
//        description.accessibilityLabel = description.text
        return description
    }()

    private lazy var hourCell: UILabel = {
        let description = UILabel()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.adjustsFontForContentSizeCategory = true
        description.font = UIFont.preferredFont(forTextStyle: .footnote)
//        description.isAccessibilityElement = true
//        description.accessibilityLabel = description.text
        return description
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}

extension NotificationViewCell {
    func setup(viewModel: NotificationsTask) {
        imageCell.image = UIImage(named: viewModel.icon)
        titleCell.text = viewModel.title
        descriptionCell.text = viewModel.description
        hourCell.text = viewModel.getHour()
        groupAccessible()
    }
}

extension NotificationViewCell: ViewCoding {
    func setupView() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            cell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            cell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            cell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
            cell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7),
            
            imageCell.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
            imageCell.widthAnchor.constraint(equalTo: cell.widthAnchor, multiplier: 0.15),
            imageCell.heightAnchor.constraint(equalTo: imageCell.widthAnchor),
            imageCell.leadingAnchor.constraint(equalToSystemSpacingAfter: cell.leadingAnchor, multiplier: 1),

            titleCell.topAnchor.constraint(equalTo: cell.topAnchor, constant: 12),
            titleCell.leadingAnchor.constraint(equalToSystemSpacingAfter: imageCell.trailingAnchor, multiplier: 1.5),
            titleCell.widthAnchor.constraint(equalTo: cell.widthAnchor, multiplier: 0.70),

            descriptionCell.topAnchor.constraint(equalTo: titleCell.bottomAnchor, constant: 4),
            descriptionCell.leadingAnchor.constraint(equalTo: titleCell.leadingAnchor),
            descriptionCell.trailingAnchor.constraint(equalTo: titleCell.trailingAnchor),
            descriptionCell.centerYAnchor.constraint(equalTo: cell.centerYAnchor, constant: 10),

            hourCell.topAnchor.constraint(equalTo: titleCell.topAnchor),
            hourCell.trailingAnchor.constraint(equalTo: titleCell.trailingAnchor, constant: 18),
            hourCell.bottomAnchor.constraint(equalTo: titleCell.bottomAnchor),
  
        ])
    }
    
    func setupHierarchy() {
        contentView.addSubview(cell)
        cell.addSubview(imageCell)
        cell.addSubview(titleCell)
        cell.addSubview(descriptionCell)
        cell.addSubview(hourCell)
    }
}

extension NotificationViewCell {

    private func groupAccessible() {

        self.titleCell.accessibilityLabel = "Etapa de cuidado pendente, título: \(titleCell.text ?? "etapa de skincare não carregada")"
        self.descriptionCell.accessibilityLabel = "descrição: \(descriptionCell.text ?? "descrição não carregada")"
        self.hourCell.accessibilityLabel = "Horário de envio da notificação: \(hourCell.text ?? "horário indisponível")"

    }
}
