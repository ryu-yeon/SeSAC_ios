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
}

//struct Genre {
//    let code: [JSON: String] = [16: "Animation", 80: "Crime", 18: "Drama", 28: "Action", 35: "Comedy", 9648: "Mystery"]
//}
