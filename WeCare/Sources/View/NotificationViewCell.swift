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
        cell.layer.cornerRadius = 22
        return cell
    }()
    
    private lazy var imageCell: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "sun.max.fill")
        image.tintColor = .systemBackground
        return image
    }()
    
    private lazy var titleCell: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = .systemFont(ofSize: 18, weight: .semibold)
        title.text = ("Testando Título")
        return title
    }()
    
    private lazy var descriptionCell: UILabel = {
        let description = UILabel()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.font = .systemFont(ofSize: 12, weight: .regular)
        description.text = ("Testando descrição de item de rotina skincare")
        return description
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
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
    func setupView() {
        contentView.addSubview(cell)
        cell.addSubview(imageCell)
        cell.addSubview(titleCell)
        cell.addSubview(descriptionCell)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            cell.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            cell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            cell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -13),
            cell.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -10),
            
            titleCell.topAnchor.constraint(equalTo: cell.topAnchor, constant: 20),
            titleCell.leadingAnchor.constraint(equalTo: imageCell.trailingAnchor, constant: 20),
            titleCell.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -128),
            titleCell.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -32),
            
            imageCell.topAnchor.constraint(equalTo: cell.topAnchor, constant: 14),
            imageCell.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 12),
            imageCell.trailingAnchor.constraint(equalTo: titleCell.leadingAnchor, constant: -4),
            imageCell.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -14),
            
            descriptionCell.topAnchor.constraint(equalTo: titleCell.bottomAnchor, constant: 6),
            descriptionCell.leadingAnchor.constraint(equalTo: titleCell.leadingAnchor),
            descriptionCell.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -30),
            descriptionCell.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -15)
        ])
    }
    
    func setupHierarchy() { }
    
    
}
