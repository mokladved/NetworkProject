//
//  BOTextField.swift
//  NetworkProject
//
//  Created by Youngjun Kim on 7/23/25.
//

import UIKit

class BOTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.borderStyle = .none
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
