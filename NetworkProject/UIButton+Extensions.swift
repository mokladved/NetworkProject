//
//  UIButton+Extensions.swift
//  NetworkProject
//
//  Created by Youngjun Kim on 7/23/25.
//

import UIKit

extension UIButton.Configuration {
    static func myStyle(title: String) -> UIButton.Configuration {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .systemBlue
        configuration.baseForegroundColor = .white
        configuration.cornerStyle = .large
        
        var attributedTitle = AttributedString(title)
        attributedTitle.font = .systemFont(ofSize: 17, weight: .bold)
        configuration.attributedTitle = attributedTitle
        
        return configuration
    }
}
