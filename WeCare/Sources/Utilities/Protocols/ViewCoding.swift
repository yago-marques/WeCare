//
//  ViewCoding.swift
//  WeCare
//
//  Created by Emilly Maia on 11/02/23.
//

import Foundation

protocol ViewCoding {
    func setupView()
    func setupConstraints()
    func setupHierarchy()
}

extension ViewCoding {
    func buildLayout() {
        setupHierarchy()
        setupView()
        setupConstraints()
    }
}
