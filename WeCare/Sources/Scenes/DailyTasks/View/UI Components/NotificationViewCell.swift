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
        cell.backgroundColor = .systemGray6
        cell.layer.cornerCurve = .circular
        cell.layer.cornerRadius = 12
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.2
        cell.layer.masksToBounds = false
        cell.layer.shadowOffset = CGSize(width: -1, height: 1)
        cell.layer.shadowRadius = 3
        return cell
    }()
    
    private lazy var imageCell: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .yellow
        return image
    }()
    
    private lazy var titleCell: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 0
        title.adjustsFontForContentSizeCategory = true
        title.font = UIFont.preferredFont(forTextStyle: .title3)
        return title
    }()
    
    private lazy var descriptionCell: UILabel = {
        let description = UILabel()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.numberOfLines = 0
        description.adjustsFontForContentSizeCategory = true
        description.font = UIFont.preferredFont(forTextStyle: .caption1)
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
        imageCell.image = UIImage(systemName: viewModel.icon)
        titleCell.text = viewModel.title
        descriptionCell.text = viewModel.description
    }
}

extension NotificationViewCell: ViewCoding {
    func setupView() {
        self.selectionStyle = .none
        self.backgroundColor = .systemBackground
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            cell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            cell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            cell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            cell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            imageCell.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
            imageCell.widthAnchor.constraint(equalTo: cell.widthAnchor, multiplier: 0.15),
            imageCell.heightAnchor.constraint(equalTo: imageCell.widthAnchor),
            imageCell.leadingAnchor.constraint(equalToSystemSpacingAfter: cell.leadingAnchor, multiplier: 1),

            titleCell.topAnchor.constraint(equalTo: cell.topAnchor, constant: 10),
            titleCell.leadingAnchor.constraint(equalToSystemSpacingAfter: imageCell.trailingAnchor, multiplier: 0.5),
            titleCell.widthAnchor.constraint(equalTo: cell.widthAnchor, multiplier: 0.75),

            descriptionCell.topAnchor.constraint(equalToSystemSpacingBelow: titleCell.bottomAnchor, multiplier: 0.1),
            descriptionCell.leadingAnchor.constraint(equalTo: titleCell.leadingAnchor),
            descriptionCell.trailingAnchor.constraint(equalTo: cell.trailingAnchor),
            descriptionCell.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -15),
        ])
    }
    
    func setupHierarchy() {
        contentView.addSubview(cell)
        cell.addSubview(imageCell)
        cell.addSubview(titleCell)
        cell.addSubview(descriptionCell)
    }
}
