//
//  LottoViewController.swift
//  NetworkProject
//
//  Created by Youngjun Kim on 7/23/25.
//

import UIKit
import SnapKit

class LottoViewController: UIViewController {

    let textField = {
        let textField = LottoTextField()
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()

    }
    

}

extension LottoViewController: ViewDesignProtocol {
    func configureHierarchy() {
        view.addSubview(textField)
    }
    
    func configureLayout() {
        textField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(44)
            make.height.equalTo(50)
        }
    }
    
    func configureView() {
        view.backgroundColor = .white
    }
    
    
}
