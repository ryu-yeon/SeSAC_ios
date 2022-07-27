//
//  Movie.swift
//  TrendMedia
//
//  Created by 유연탁 on 2022/07/20.
//

import Foundation

struct Movie {
    var title: String
    var releaseDate: String
    var runtime: Int
    var overview: String
    var rate: Double
}

class User {
    internal init(name: String, age: Int) {
        self.name = name
        self.age = age
    }

    var name: String
    var age: Int
    
    
}
