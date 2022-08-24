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
    
    func requestImage(_ text: String, completionHandler: @escaping ([String], [String]) -> Void) {
        let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = EndPoint.unsplashPhoto + "query=\(query)" + "&client_id=\(APIKey.unsplashId)"
        
        var imageList: [String] = []
        var thumbnailList: [String] = []
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("JSON: \(json)")
                
                for image in json["results"].arrayValue {
                    imageList.append(image["urls"]["regular"].stringValue)
                    thumbnailList.append(image["urls"]["thumb"].stringValue)
                }
                completionHandler(imageList, thumbnailList)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
