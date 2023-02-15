//
//  NotificationsViewController.swift
//  WeCare
//
//  Created by Emilly Maia on 11/02/23.
//

import Foundation
import UIKit

class NotificationsTableViewController: UIViewController {
    
    private var notificationsTableView = NotificationsTableView()
    
    override func viewDidLoad() {
        view = notificationsTableView
        notificationsTableView.tableView.delegate = self
        notificationsTableView.tableView.dataSource = self
    }
}

extension NotificationsTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NotificationViewCell.identifier, for: indexPath) as? NotificationViewCell else {
            return UITableViewCell(style: .default, reuseIdentifier: NotificationViewCell.identifier)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sheetViewController = StepByStepViewController(nibName: nil, bundle: nil)
        present(sheetViewController, animated: true, completion: nil)
        return
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24
    }
    
    
}
