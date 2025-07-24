//
//  BoxOfficeViewController.swift
//  NetworkProject
//
//  Created by Youngjun Kim on 7/23/25.
//

import UIKit

final class BoxOfficeViewController: UIViewController {
    private let movieInfo = MovieInfo.movies
    
    private var filteredMovieInfo: [Movie] = []

    
    private let tableView = UITableView()
    
    private let searchTextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        return textField
    }()
    
    private let lineView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let searchButton = {
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
        filteredMovieInfo = movieInfo
        configureHierarchy()
        configureLayout()
        configureView()
        configureAction()
    }
    
    private func configureAction() {
        searchTextField.addTarget(self, action: #selector(textFieldReturned), for: .editingDidEndOnExit)
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    private func executeSearch() {
        filteredMovieInfo = Array(movieInfo.shuffled().prefix(10))
        tableView.reloadData()
        view.endEditing(true)
    }

    @objc private func textFieldReturned() {
        executeSearch()
    }

    @objc private func searchButtonTapped() {
        executeSearch()
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
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchButton.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)

        }
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
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BOTableViewCell.self, forCellReuseIdentifier: BOTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension

    }
    
    
}

extension BoxOfficeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovieInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BOTableViewCell.identifier, for: indexPath) as! BOTableViewCell
        let movie = filteredMovieInfo[indexPath.row]
        let rank = indexPath.row + 1
        let data = (movie: movie, rank: rank)
        cell.configure(from: data)
        cell.backgroundColor = .clear
        return cell
    }
}
