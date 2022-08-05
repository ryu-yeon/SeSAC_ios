//
//  MovieModel.swift
//  TMDB
//
//  Created by 유연탁 on 2022/08/04.
//

import Foundation

struct MovieModel {
    let id: Int
    let posterURL: String
    let title: String
    let imageURL: String
    let overview: String
    let releaseDate: String
    let genre: [Int]
}

