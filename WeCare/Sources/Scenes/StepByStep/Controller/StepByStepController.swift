//
//  StepByStepViewController.swift
//  WeCare
//
//  Created by Emilly Maia on 14/02/23.
//
import Foundation
import UIKit

class StepByStepViewController: UIViewController {

    private var stepByStepView = StepByStepView()

    override func viewDidLoad() {
        view = stepByStepView
        stepByStepView.delegate = self
        stepByStepView.tableView.delegate = self
        stepByStepView.tableView.dataSource = self
        view.backgroundColor = .systemBackground
    }
}

extension StepByStepViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 13
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StepByStepViewCell.identifier, for: indexPath) as? StepByStepViewCell else {
            return UITableViewCell(style: .default, reuseIdentifier: StepByStepViewCell.identifier)
        }

        return cell
    }

}
