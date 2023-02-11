//
//  WeatherCardView.swift
//  WeCare
//
//  Created by Emilly Maia on 10/02/23.
//

import Foundation
import UIKit

class WeatherCardView: UIView {
    
    lazy var weatherCard: UIView = {
        let card = UIView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.backgroundColor = .init(red: 0.17, green: 0.59, blue: 0.96, alpha: 1.00)
        card.layer.shadowColor = .init(red: 0, green: 0, blue: 0, alpha: 0.2)
        card.layer.shadowOffset = CGSizeMake(4.0, 4.0)
        card.layer.shadowRadius = 0.9
        card.layer.shadowOpacity = 12
        return card
    }()
    
    private lazy var icon: UIImageView =  {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit
        icon.image = UIImage(named: "circle.fill")
        return icon
    }()
    
    private lazy var uvIndex: UILabel = {
        let uvIndex = UILabel()
        return uvIndex
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension WeatherCardView: ViewCoding {
    func setupView() {
        
    }
    
    func setupConstraints() {
        
    }
    
    func setupHierarchy() {
        addSubview(weatherCard)
        weatherCard.addSubview(icon)
    }
    
    
}


