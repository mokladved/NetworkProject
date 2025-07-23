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
    
    let labelWrappedView = {
        let view = UIView()
        return view
    }()
    
    let infoLabel = {
        let label = UILabel()
        label.text = "당첨번호 안내"
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    let dateLabel = {
        let label = UILabel()
        label.text = "2020-05-30 추첨"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    let lineView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
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
        view.addSubview(labelWrappedView)
        labelWrappedView.addSubview(infoLabel)
        labelWrappedView.addSubview(dateLabel)
        view.addSubview(lineView)
    }
    
    func configureLayout() {
        textField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(44)
            make.height.equalTo(50)
        }
        
        labelWrappedView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.top.equalTo(textField.snp.bottom).offset(20)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.leading.equalTo(labelWrappedView.snp.leading)
            make.centerY.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints { make in
            make.trailing.equalTo(labelWrappedView.snp.trailing)
            make.centerY.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(labelWrappedView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(labelWrappedView)
            make.height.equalTo(1)
        }
    }
    
    func configureView() {
        view.backgroundColor = .white
    }
    
    
}
