//
//  URL+Extension.swift
//  SeSacWeek6
//
//  Created by 유연탁 on 2022/08/08.
//

import Foundation

extension URL {
    static let baseURL = "https://dapi.kakao.com/v2/search/"
    
    static func makeEndPoingString(_ endpoint: String) -> String {
        return baseURL + endpoint
    }
}
