//
//  LottoViewController.swift
//  NetworkProject
//
//  Created by Youngjun Kim on 7/23/25.
//

import UIKit
import SnapKit

class LottoViewController: UIViewController {
    
    let rounds = Array(1...1181)
    
    let pickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()

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
    
    let resultLabel = {
        let label = UILabel()
        
        let roundNumber = "913회"
        let fixedText = "당첨결과"
        let resultText = "\(roundNumber) \(fixedText)"
        let attributedText = NSMutableAttributedString(string: resultText)
        let frontRange = (resultText as NSString).range(of: roundNumber)
        let backRange = (resultText as NSString).range(of: fixedText)
        let frontAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemYellow,
            .font: UIFont.systemFont(ofSize: 20, weight: .bold)
        ]
        let backAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 20, weight: .semibold)
        ]
        attributedText.addAttributes(frontAttributes, range: frontRange)
        attributedText.addAttributes(backAttributes, range: backRange)
        label.attributedText = attributedText
        return label
    }()
    
    let firstButton = {
        let number = "6"
        let button = UIButton()
        button.configuration = .circle(title: number)
        return button
    }()
    
    override func viewDidLayoutSubviews() {
        firstButton.layer.cornerRadius = firstButton.frame.height / 2
        firstButton.clipsToBounds = true
        for button in numberStackView.arrangedSubviews {
            button.snp.makeConstraints { make in
                make.height.equalTo(button.snp.width)
            }
        }

    }
    
    let secondButton = {
        let number = "14"
        let button = UIButton()
        button.configuration = .circle(title: number)
        return button
    }()
    
    let thirdButton = {
        let number = "16"
        let button = UIButton()
        button.configuration = .circle(title: number)
        return button
    }()
    
    let fourthButton = {
        let number = "21"
        let button = UIButton()
        button.configuration = .circle(title: number)
        return button
    }()
    
    let fifthButton = {
        let number = "27"
        let button = UIButton()
        button.configuration = .circle(title: number)
        return button
    }()
    
    let sixthButton = {
        let number = "37"
        let button = UIButton()
        button.configuration = .circle(title: number)
        return button
    }()
    
    let plusButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        return button
    }()
    
    let bonusButton = {
        let number = "40"
        let button = UIButton()
        button.configuration = .circle(title: number)
        return button
    }()
    
    let numberStackView = {
        let sv = UIStackView()
        sv.spacing = 10
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        return sv
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
        view.addSubview(resultLabel)
        
        view.addSubview(numberStackView)
        numberStackView.addArrangedSubview(firstButton)
        numberStackView.addArrangedSubview(secondButton)
        numberStackView.addArrangedSubview(thirdButton)
        numberStackView.addArrangedSubview(fourthButton)
        numberStackView.addArrangedSubview(fifthButton)
        numberStackView.addArrangedSubview(sixthButton)
        numberStackView.addArrangedSubview(plusButton)
        numberStackView.addArrangedSubview(bonusButton)
        
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
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(30)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        numberStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(labelWrappedView)
            make.top.equalTo(resultLabel.snp.bottom).offset(20)
            make.height.equalTo(50)
            
        }
    
    }
    
    func configureView() {
        view.backgroundColor = .white
        pickerView.delegate = self
        pickerView.dataSource = self
        textField.inputView = pickerView
    }
}

extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return rounds.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(rounds[row])"
    }
    
}
