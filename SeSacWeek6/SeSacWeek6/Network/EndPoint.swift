//
//  EndPoint.swift
//  SeSacWeek6
//
//  Created by 유연탁 on 2022/08/08.
//

import Foundation

//enum에서 저장 프로퍼티는 못 쓰고 연산 프로퍼티는 쓸 수 있는 이유?
//초기화 X
enum EndPoint {
    case blog
    case cafe
    
    var requestURL: String {
        switch self {
        case .blog:
            return URL.makeEndPoingString("blog?query=")
        case .cafe:
            return URL.makeEndPoingString("cafe?query=")
        }
    }
}
