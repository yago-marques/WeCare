//
//  Cabecalho.swift
//  WeCare
//
//  Created by Emilly Maia on 10/02/23.
//

import Foundation
import UIKit

class Cabecalho: UIView {
    
    private lazy var data: UILabel = {
        let data = UILabel()
        data.translatesAutoresizingMaskIntoConstraints = false
        data.text = ("\(Date().displayFormat)")
        data.font = .systemFont(ofSize: 16, weight: .light)
        data.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return data
    }()
    
    private lazy var greetings: UILabel = {
        let greetings = UILabel()
        greetings.text = ("\(Date().greetingMessage), Emilly")
        greetings.translatesAutoresizingMaskIntoConstraints = false
        greetings.font = .systemFont(ofSize: 32, weight: .regular)
        greetings.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return greetings
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension Cabecalho: ViewCoding {
    func setupView() { }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            data.topAnchor.constraint(equalTo: topAnchor, constant: 64),
            data.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            
            greetings.topAnchor.constraint(equalTo: data.bottomAnchor, constant: 12),
            greetings.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
        ])
    }
    
    func setupHierarchy() {
        addSubview(data)
        addSubview(greetings)
    }
}
extension Date {
    var displayFormat: String {
        self.formatted(date: .long, time: .omitted)
    }
    
    var greetingMessage: String {
        let hour = Calendar.current.component(.hour, from: Date())
        if hour <= 12 {
            return "Good Morning"
        } else if hour > 12 && hour < 18 {
            return "Good afternoon"
        }
        return "Good evening"
    }
}
