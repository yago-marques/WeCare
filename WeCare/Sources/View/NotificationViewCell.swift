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
        return image
    }()
    
    private lazy var titleCell: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = .systemFont(ofSize: 18, weight: .regular)
        return title
    }()
    
    private lazy var descriptionCell: UILabel = {
        let description = UILabel()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.font = .systemFont(ofSize: 12, weight: .regular)
        return description
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
    
    func setupConstraints() { }
    
    func setupHierarchy() { }
    
    
}
