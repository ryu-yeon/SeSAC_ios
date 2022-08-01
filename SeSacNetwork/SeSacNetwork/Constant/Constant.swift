//
//  Constant.swift
//  SeSacNetwork
//
//  Created by 유연탁 on 2022/08/01.
//

import Foundation

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
