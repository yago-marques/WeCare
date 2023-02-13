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
        cell.backgroundColor = UIColor(red: 0.64, green: 0.73, blue: 0.72, alpha: 1)
        cell.layer.cornerCurve = .circular
        cell.layer.cornerRadius = 12
        return cell
    }()
    
    private lazy var imageCell: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "sun.max.fill")
        image.tintColor = .yellow
        return image
    }()
    
    private lazy var titleCell: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Testando Título"
        title.numberOfLines = 0
        title.adjustsFontForContentSizeCategory = true
        title.font = UIFont.preferredFont(forTextStyle: .title3)
        return title
    }()
    
    private lazy var descriptionCell: UILabel = {
        let description = UILabel()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.text = ("Testando descrição de item de rotina skincare")
        description.numberOfLines = 0
        description.adjustsFontForContentSizeCategory = true
        description.font = UIFont.preferredFont(forTextStyle: .caption1)
        return description
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleCell.text = nil
        descriptionCell.text = nil
        imageCell.image = nil
    }
}

extension NotificationViewCell {
    
    public func configureCellInformations(title: String, description: String, image: String) {
        imageCell.image = UIImage(named: image)
        titleCell.text = title
        descriptionCell.text = description
    }
}

extension NotificationViewCell: ViewCoding {
    func setupView() { }
    
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
//
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
