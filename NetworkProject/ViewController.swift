//
//  ViewController.swift
//  NetworkProject
//
//  Created by Youngjun Kim on 7/23/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let buttonStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let lottoButton = {
        let button = UIButton()
        button.configuration = .myStyle(title: "로또")
        return button
        
    }()
    
    let movieButton = {
        let button = UIButton()
        button.configuration = .myStyle(title: "박스오피스")
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
    }


}

extension ViewController: ViewDesignProtocol {
    func configureHierarchy() {
        view.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(lottoButton)
        buttonStackView.addArrangedSubview(movieButton)
    }
    
    func configureLayout() {
        buttonStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.center.equalToSuperview()
        }
        
        lottoButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(buttonStackView)
            make.height.equalTo(100)
        }
        
        movieButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(buttonStackView)
            make.height.equalTo(100)
        }
    }
    
    func configureView() {
        view.backgroundColor = .white
    }
    
    
}
