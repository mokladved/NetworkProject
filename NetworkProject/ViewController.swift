//
//  ViewController.swift
//  NetworkProject
//
//  Created by Youngjun Kim on 7/23/25.
//

import UIKit
import SnapKit

final class ViewController: UIViewController {
    
    private let buttonStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let lottoButton = {
        let button = UIButton()
        button.tag = 0
        button.configuration = .myStyle(title: "로또")
        return button
        
    }()
    
    private let movieButton = {
        let button = UIButton()
        button.tag = 1
        button.configuration = .myStyle(title: "박스오피스")
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
        configureButtonAction()
    }
    
    private func configureButtonAction() {
        lottoButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        movieButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            let lottoVC = LottoViewController()
            present(lottoVC, animated: true)
        case 1:
            let BoxVC = BoxOfficeViewController()
            present(BoxVC, animated: true)
        default:
            break
        }
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
