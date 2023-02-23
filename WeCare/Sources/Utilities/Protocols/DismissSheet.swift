//
//  DismissSheet.swift
//  WeCare
//
//  Created by Yago Marques on 23/02/23.
//

import Foundation

protocol DismissSheetDelegate: AnyObject {
    func dismiss()
}

extension StepByStepViewController: DismissSheetDelegate {
    func dismiss() {
        dismiss(animated: true)
    }
}
