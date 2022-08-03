//
//  Constant.swift
//  SeSacNetwork
//
//  Created by 유연탁 on 2022/08/01.
//

import Foundation

struct APIKey {
    static let BOXOFFICE = "53031b8997c29ad483682633e8bfe30d"
    static let NAVER_ID = "1NbmAsJwdmGxOVE4nruK"
    static let NAVER_SECRET = "_5u3jvJQf9"
}

struct EndPoint {
    static let boxOfficeURL = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
    static let lottoURL = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber"
    static let translateURL = "https://openapi.naver.com/v1/papago/n2mt"
    static let beerURL = "https://api.punkapi.com/v2/beers"
    static let imageSearchURL = "https://openapi.naver.com/v1/search/image.json?"
}


//enum StoryboardName {
//    case Main
//    case Search
//    case Setting
//}


//struct StoryboardName {
//    static let main = "Main"
//    static let search = "Search"
//    static let setting = "Setting"
//}

/*
 1. struct type property vs enum type property => 열거형은 인스턴스 생성 방지
 2. enum case vs enum static => 중복, case 제약
 */


//열거형은 인스턴스를 만들지 못함
enum StoryboardName {
    static let main = "Main"
    static let search = "Search"
    static let setting = "Setting"
}

enum FontName {
    
}
