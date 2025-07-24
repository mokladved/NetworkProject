//
//  BOTableViewCell.swift
//  NetworkProject
//
//  Created by Youngjun Kim on 7/23/25.
//

import UIKit

final class BOTableViewCell: UITableViewCell {

    static let identifier = "BOTableViewCell"
    
    private let rankButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .white
        configuration.baseForegroundColor = .black
        configuration.cornerStyle = .fixed
        configuration.background.cornerRadius = 0
        button.configuration = configuration
        return button
    }()
    
    private let movieTitleLabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
        
    }()
    
    private let dateLabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
        configureView()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BOTableViewCell: ViewDesignProtocol {
    func configureHierarchy() {
        contentView.addSubview(rankButton)
        contentView.addSubview(movieTitleLabel)
        contentView.addSubview(dateLabel)
    }
    
    func configureLayout() {
        rankButton.snp.makeConstraints { make in
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(30)
            make.width.equalTo(45)
            make.centerY.equalTo(contentView)
        }
        
        movieTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(rankButton.snp.trailing).offset(20)
            make.centerY.equalTo(contentView)
            make.trailing.lessThanOrEqualTo(dateLabel.snp.leading).offset(-12)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.snp.trailing).inset(20)
            make.centerY.equalTo(contentView)
        }
    }
    
    func configureView() {
        contentView.backgroundColor = .clear
    }
}

extension BOTableViewCell: Configurable {
    typealias Data = MovieInfoDetail
    
    func configure(from data: Data) {
        movieTitleLabel.text = data.movieNm
        dateLabel.text = data.openDt
        var configuration = rankButton.configuration
        var attributedTitle = AttributedString("\(data.rank)")
        attributedTitle.font = .systemFont(ofSize: 14, weight: .bold)
        configuration?.attributedTitle = attributedTitle
        rankButton.configuration = configuration
    }
}
