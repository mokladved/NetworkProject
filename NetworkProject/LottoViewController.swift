//
//  LottoViewController.swift
//  NetworkProject
//
//  Created by Youngjun Kim on 7/23/25.
//

import UIKit
import SnapKit
import Alamofire

final class LottoViewController: UIViewController {
    
    private let rounds = Array(1...1181)
    private let defaultRound = 1181
    
    private let pickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()

    private let textField = {
        let textField = LottoTextField()
        return textField
    }()
    
    private let labelWrappedView = {
        let view = UIView()
        return view
    }()
    
    private let infoLabel = {
        let label = UILabel()
        label.text = "당첨번호 안내"
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    private let dateLabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    private let lineView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let resultLabel = {
        let label = UILabel()
        return label
    }()
    
    private let numberStackView = {
        let sv = UIStackView()
        sv.spacing = 5
        sv.axis = .horizontal
        sv.distribution = .equalSpacing
        sv.alignment = .firstBaseline
        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
        callRequest(for: defaultRound)
    }
}

extension LottoViewController {
    private func getColor(for number: Int) -> UIColor {
        switch number {
        case 1...10:
            return .systemYellow
        case 11...20:
            return .systemBlue
        case 21...30:
            return .systemRed
        case 31...40:
            return .systemGray
        default:
            return .systemGreen
        }
    }
    
    private func updateResultUI(from data: Lotto) {
        let round = data.drwNo
        let date = data.drwNoDate
        updateResultLabel(for: round)
            
        dateLabel.text = "\(date)"

        let winningNumbers = [data.drwtNo1, data.drwtNo2, data.drwtNo3, data.drwtNo4, data.drwtNo5, data.drwtNo6]
        let sixNumbers = winningNumbers.sorted()
        let bonus = data.bnusNo
    
        updateLotto(numbers: sixNumbers, bonus: bonus)
    }
    
    private func updateResultLabel(for round: Int) {
        let roundText = "\(round)회"
        let fixedText = " 당첨결과"
        let concatenatedText = roundText + fixedText
            
        let attributedString = NSMutableAttributedString(string: concatenatedText)
            
        let frontRange = (concatenatedText as NSString).range(of: roundText)
        let backRange = (concatenatedText as NSString).range(of: fixedText)
            
        attributedString.addAttributes([
            .foregroundColor: UIColor.systemYellow,
            .font: UIFont.systemFont(ofSize: 20, weight: .bold)
        ], range: frontRange)
            
        attributedString.addAttributes([
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 20, weight: .semibold)
        ], range: backRange)
        
        resultLabel.attributedText = attributedString
    }
    
    private func updateLotto(numbers: [Int], bonus: Int) {
        numberStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
            
        for number in numbers {
            let color = getColor(for: number)
            let button = configureNumbersButtonUI(with: "\(number)", color: color)
            numberStackView.addArrangedSubview(button)
        }
            
           
        let plusButton = configurePlustButtonUI()
        numberStackView.addArrangedSubview(plusButton)
        
        let bonusColor = getColor(for: bonus)
        let bonusView = createBonusStackView(with: "\(bonus)", color: bonusColor)
        numberStackView.addArrangedSubview(bonusView)
        }
    
    private func createBonusStackView(with title: String, color: UIColor) -> UIStackView {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.spacing = 4
            stackView.alignment = .center

            let button = configureNumbersButtonUI(with: title, color: color)

            let label = UILabel()
            label.text = "보너스"
            label.font = .systemFont(ofSize: 12)
            label.textColor = .darkGray

            stackView.addArrangedSubview(button)
            stackView.addArrangedSubview(label)

            return stackView
        }
    
    private func configureNumbersButtonUI(with title: String, color: UIColor) -> UIButton {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = color
        config.baseForegroundColor = .white
        config.cornerStyle = .capsule
        
        var attributedTitle = AttributedString(title)
        attributedTitle.font = .systemFont(ofSize: 15, weight: .semibold)
        config.attributedTitle = attributedTitle
        
        button.configuration = config
        
        button.snp.makeConstraints { make in
            make.width.height.equalTo(44)
        }
        return button
    }
    
    private func configurePlustButtonUI() -> UIButton {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "plus")
        button.configuration = config
        button.tintColor = .darkGray
        return button
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
        }
        
        for button in numberStackView.arrangedSubviews {
            button.snp.makeConstraints { make in
                make.width.height.equalTo(44)
            }
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let round = rounds[row]
        callRequest(for: round)
        textField.text = "\(round)"
            
        view.endEditing(true)
    }
    
}

extension LottoViewController: Networkable {
    typealias Data = Int
    func callRequest(for data: Data) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(data)"
        AF.request(url  , method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Lotto.self) { response in
                switch response.result {
                case .success(let value):
                    self.updateResultUI(from: value)
                case .failure(let error):
                    print(error)
                }
        }
    }
}
