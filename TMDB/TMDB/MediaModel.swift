//
//  MediaModel.swift
//  TMDB
//
//  Created by 유연탁 on 2022/08/04.
//

import Foundation
import SwiftyJSON

struct MediaModel {
    let title: String
    let imageURL: String
    let overview: String
    let releaseDate: String
    let genre: [JSON]
//    let cast: [String]
}

