//
//  BoxOfficeViewController.swift
//  NetworkProject
//
//  Created by Youngjun Kim on 7/23/25.
//

import UIKit
import Alamofire

final class BoxOfficeViewController: UIViewController {
    let apiKey = Key.apiKey
    private let defaultDate = "20250723"
    
    private let movieInfo = MovieInfo.movies
    private var filteredMovieInfo: [MovieInfoDetail] = []

    private let tableView = UITableView()
    
    private let searchTextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.textColor = .white
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
        configureHierarchy()
        configureLayout()
        configureView()
        configureAction()
        callRequest(for: defaultDate)
    }
    
    private func configureAction() {
        searchTextField.addTarget(self, action: #selector(textFieldReturned), for: .editingDidEndOnExit)
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    private func executeSearch() {
        let date = searchTextField.text
        guard let date = isValid(of: date) else {
            return
        }
        callRequest(for: date)
        tableView.reloadData()
        view.endEditing(true)
    }
    
    private func isValid(of data: String?) -> String? {
        guard let date = data,
              !date.trimmingCharacters(in: .whitespaces).isEmpty,
              let _ = Int(date) else {
            return nil
        }
        return date
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
        let movieInfo = filteredMovieInfo[indexPath.row]
        cell.configure(from: movieInfo)
        cell.backgroundColor = .clear
        return cell
    }
}

extension BoxOfficeViewController: Networkable {
    typealias Data = String
    
    func callRequest(for date: Data) {
        let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(apiKey)&targetDt=\(date)"
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: BoxOffice.self) { response in
                switch response.result {
                case .success(let value):
                    self.filteredMovieInfo = value.boxOfficeResult.dailyBoxOfficeList
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
            }
        }
    }
}
