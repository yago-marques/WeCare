//
//  StepByStepViewController.swift
//  WeCare
//
//  Created by Emilly Maia on 14/02/23.
//
import Foundation
import UIKit

class StepByStepViewController: UIViewController {

    private var stepByStepView: StepByStepView
    var viewModel: NotificationsTask

    init(stepByStepView: StepByStepView = StepByStepView(), viewModel: NotificationsTask) {
        self.stepByStepView = stepByStepView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }

    func setupView() {
        DispatchQueue.main.async {
            self.view = self.stepByStepView
        }
        stepByStepView.setupView(viewModel: self.viewModel)
        stepByStepView.delegate = self
        stepByStepView.tableView.delegate = self
        stepByStepView.tableView.dataSource = self
    }
}

extension StepByStepViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.steps.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StepByStepViewCell.identifier, for: indexPath) as? StepByStepViewCell else {
            return UITableViewCell(style: .default, reuseIdentifier: StepByStepViewCell.identifier)
        }

        let cellViewModel = self.viewModel.steps[indexPath.row]
        let isLast = indexPath.row == (viewModel.steps.count - 1)
        cell.configureCellInformations(title: cellViewModel.title, description: cellViewModel.description, isLast: isLast)

        return cell
    }

}
