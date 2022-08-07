//
//  TMDBAPIManager.swift
//  TMDB
//
//  Created by 유연탁 on 2022/08/05.
//

import UIKit

import Alamofire
import SwiftyJSON

class TMDBAPIMagnager {
    
    static let shared = TMDBAPIMagnager()
    
    private init() {}
    
    typealias completionHandler = ([MovieModel], Int) -> Void
    typealias completionHandler2 = ([CastModel]) -> Void
    
    func requestTrendingData(startPage: Int, completionHandler: @escaping completionHandler) {
        let url = EndPoint.TrendURL + "/movie/day?api_key=" + APIKey.TMDB + "&page=\(startPage)"
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)

                var list: [MovieModel] = []
                
                for media in json["results"].arrayValue {
                    let title = media["title"].stringValue
                    let imageURL = media["backdrop_path"].stringValue
                    let overview = media["overview"].stringValue
                    let releaseDate = media["release_date"].stringValue
                    let genre = media["genre_ids"].arrayValue.map {$0.intValue}
                    let id = media["id"].intValue
                    let posterURL = media["poster_path"].stringValue

                    let data = MovieModel(id: id, posterURL: posterURL, title: title, imageURL: imageURL, overview: overview, releaseDate: releaseDate, genre: genre)
                    
                    list.append(data)
                }

                let totalCount = json["total_pages"].intValue

                completionHandler(list, totalCount)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestMovieData(movieId: Int, compeltionHandeler2: @escaping completionHandler2) {
        let url = EndPoint.MovieURL + "/\(movieId)/credits?api_key=" + APIKey.TMDB + "&language=en-US"
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                var castList: [CastModel] = []
                
                var casts: [String] = []
                var characters: [String] = []
                var imageURL: [String] = []
                
                for person in json["cast"].arrayValue {
                    casts.append(person["name"].stringValue)
                    characters.append(person["character"].stringValue)
                    imageURL.append(person["profile_path"].stringValue)
                }
                
                let data = CastModel(casts: casts, characters: characters, imageURL: imageURL)
                
                castList.append(data)
                               
                compeltionHandeler2(castList)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
