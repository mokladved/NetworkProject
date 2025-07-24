//
//  LottoTextField.swift
//  NetworkProject
//
//  Created by Youngjun Kim on 7/23/25.
//

import UIKit

class LottoTextField: UITextField {
    override init(frame: CGRect) {                                       
        super.init(frame: frame)
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        self.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
