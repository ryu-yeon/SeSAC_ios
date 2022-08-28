//
//  UnsplashAPIManager.swift
//  Diary
//
//  Created by 유연탁 on 2022/08/22.
//

import UIKit

import Alamofire
import SwiftyJSON

class UnsplashAPIManager {
    
    static let shared = UnsplashAPIManager()
    
    private init() {}
    
    func requestImage(text: String, page: Int, completionHandler: @escaping ([String], Int) -> Void) {
        let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = EndPoint.unsplashPhoto + "query=\(query)" + "&client_id=\(APIKey.unsplashId)" + "&page=\(page)"
        
        var imageList: [String] = []
        var totalPage = 0
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("JSON: \(json)")
                totalPage = json["total_pages"].intValue
                for image in json["results"].arrayValue {
                    imageList.append(image["urls"]["regular"].stringValue)
                }
                completionHandler(imageList, totalPage)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
