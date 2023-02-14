//
//  StepByStepSheetView.swift
//  WeCare
//
//  Created by Emilly Maia on 13/02/23.
//

import Foundation
import UIKit

class StepByStepSheetView: UIView {
    
    private lazy var stepIcon: UIImageView = {
        let stepIcon = UIImageView()
        stepIcon.translatesAutoresizingMaskIntoConstraints = false
        return stepIcon
    }()
    
    private lazy var stepTitle: UILabel = {
        let stepTitle = UILabel()
        stepTitle.text = "Testando rotina"
        stepTitle.numberOfLines = 0
        stepTitle.adjustsFontForContentSizeCategory = true
        stepTitle.font = UIFont.preferredFont(forTextStyle: .title2)
        return stepTitle
    }()
    
    private lazy var steps: UILabel = {
        let steps = UILabel()
        steps.translatesAutoresizingMaskIntoConstraints = false
        steps.text = "Testando passo a passo de cuidados com o rosto de acordo com a temperatura"
        steps.numberOfLines = 0
        steps.adjustsFontForContentSizeCategory = true
        steps.font = UIFont.preferredFont(forTextStyle: .caption1)
        return stepTitle
    }()
    
    init() {
        super.init(frame: .zero)
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StepByStepSheetView: ViewCoding {
    func setupView() { }
    
    func setupConstraints() { }
    
    func setupHierarchy() {
        addSubview(stepIcon)
        addSubview(stepTitle)
        addSubview(steps)
    }
    
    
}
