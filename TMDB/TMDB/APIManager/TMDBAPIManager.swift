//
//  TMDBAPIManager.swift
//  TMDB
//
//  Created by 유연탁 on 2022/08/05.
//

import UIKit

import Alamofire
import SwiftyJSON

class TMDBAPIManager {
    
    static let shared = TMDBAPIManager()
    
    private init() {}
    
    typealias completionHandler = (Int, [Int], [MediaModel]) -> Void
    
    func requestTrending(page: Int, completionHandler: @escaping completionHandler) {
        let url = EndPoint.TrendURL + "/movie/day?api_key=" + APIKey.TMDB + "&page=\(page)"
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("JSON: \(json)")
                
                var list: [MediaModel] = []
                var movieList: [Int] = []
                
                for media in json["results"].arrayValue {
                    let title = media["title"].stringValue
                    let imageURL = media["backdrop_path"].stringValue
                    let overview = media["overview"].stringValue
                    let releaseDate = media["release_date"].stringValue
                    let genre = media["genre_ids"].arrayValue.map { $0.intValue}
                  //.map {$0.intvalue}
                    movieList.append(media["id"].intValue)
//                    requestMovie(movieId: media["id"].intValue)
                    let data = MediaModel(title: title, imageURL: imageURL, overview: overview, releaseDate: releaseDate, genre: genre)
//                    print(genre)
                    list.append(data)
                }
//                for movie in movieList {
//                    self.requestMovie(movieId: movie)
//                }
                let totalCount = json["total_pages"].intValue
                
                
                completionHandler(totalCount, movieList, list)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestMovie(movieId: Int, completionHandler2: [[String]]) -> Void {
        let url = EndPoint.MovieURL + "/\(movieId)/credits?api_key=" + APIKey.TMDB + "&language=en-US"
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                var castList: [[String]] = []
    
                var casts: [String] = []
                
                for person in json["cast"].arrayValue {
                    casts.append(person["name"].stringValue)
                }
                castList.append(casts)
//                print(self.castList[0])
            case .failure(let error):
                print(error)
            }
        }

    }
    
    
    
    
}
        
