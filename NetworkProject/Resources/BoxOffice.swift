//
//  BoxOffice.swift
//  NetworkProject
//
//  Created by Youngjun Kim on 7/24/25.
//

import Foundation

struct BoxOffice: Decodable {
    let boxOfficeResult: DailyBoxOfficeList
}

struct DailyBoxOfficeList: Decodable {
    let dailyBoxOfficeList: [MovieInfoDetail]
}

struct MovieInfoDetail: Decodable {
    let rank: String
    let movieNm: String
    let openDt: String
}

