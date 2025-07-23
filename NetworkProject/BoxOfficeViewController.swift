//
//  BoxOfficeViewController.swift
//  NetworkProject
//
//  Created by Youngjun Kim on 7/23/25.
//

import UIKit

class BoxOfficeViewController: UIViewController {
    let movieInfo = MovieInfo.movies
    
    let tableView = UITableView()
    
    let searchTextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        return textField
    }()
    
    let lineView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let searchButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        
        configuration.baseForegroundColor = .black
        configuration.baseBackgroundColor = .white
        
    
        var attributedTitle = AttributedString("검색")
        attributedTitle.font = .systemFont(ofSize: 15)
        configuration.attributedTitle = attributedTitle
        configuration.cornerStyle = .fixed
        configuration.background.cornerRadius = 0
        button.configuration = configuration
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
    }
}

extension BoxOfficeViewController: ViewDesignProtocol {
    func configureHierarchy() {
        view.addSubview(tableView)
        view.addSubview(searchTextField)
        view.addSubview(lineView)
        view.addSubview(searchButton)
    }
    
    func configureLayout() {
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(44)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
            make.width.equalTo(80)
        }
        
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(searchButton.snp.top)
            make.bottom.equalTo(searchButton.snp.centerY)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(searchButton.snp.leading).offset(-20)
        }
        
        lineView.snp.makeConstraints { make in
            make.height.equalTo(3)
            make.leading.equalTo(searchTextField.snp.leading)
            make.trailing.equalTo(searchTextField.snp.trailing)
            make.bottom.equalTo(searchButton.snp.bottom)
        }
    }
    
    func configureView() {
        view.backgroundColor = .black
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
}

extension BoxOfficeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BOTableViewCell.identifier, for: indexPath)
        
        return cell
    }
    
    
}
