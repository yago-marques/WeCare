//
//  NotificationsTableView.swift
//  WeCare
//
//  Created by Emilly Maia on 10/02/23.
//

import Foundation
import UIKit

class NotificationsTableView: UIView {
    
    internal lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(NotificationViewCell.self, forCellReuseIdentifier: NotificationViewCell.identifier)
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
}

extension NotificationsTableView: ViewCoding {
    func setupHierarchy() {
        addSubview(tableView)
    }
    
    func setupView() { }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

