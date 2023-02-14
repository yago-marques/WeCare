//
//  Cabecalho.swift
//  WeCare
//
//  Created by Emilly Maia on 10/02/23.
//

import Foundation
import UIKit

class HeaderGreetings: UIView {
    
    private lazy var date: UILabel = {
        let data = UILabel()
        data.text = Date().displayFormat
        data.translatesAutoresizingMaskIntoConstraints = false
        data.font = .systemFont(ofSize: 16, weight: .light)
        return data
    }()
    
    private lazy var greetings: UILabel = {
        let greetings = UILabel()
        greetings.translatesAutoresizingMaskIntoConstraints = false
        greetings.font = .systemFont(ofSize: 32, weight: .regular)
        return greetings
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buildLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    func setup(viewModel: HeaderGreetingsViewModel?) {
        guard let viewModel else { return }
        self.greetings.text = "\(Date().greetingMessage), \(viewModel.userName)"
    }
}

extension HeaderGreetings: ViewCoding {
    func setupView() { }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            date.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            date.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85),
            date.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            greetings.topAnchor.constraint(equalToSystemSpacingBelow: date.bottomAnchor, multiplier: 1),
            greetings.widthAnchor.constraint(equalTo: date.widthAnchor),
            greetings.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    func setupHierarchy() {
        addSubview(date)
        addSubview(greetings)
    }
}

