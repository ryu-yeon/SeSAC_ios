//
//  UnsplashAPIManager.swift
//  ShoppingList
//
//  Created by 유연탁 on 2022/08/25.
//

import UIKit

import Alamofire
import SwiftyJSON

class UnsplashAPIManager {
    private init() {}
    
    static let shared = UnsplashAPIManager()
    
    func requestImage(_ text: String, completionHandler: @escaping ([String]) -> Void) {
        let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = EndPoint.unsplashPhoto + "query=\(query)" + "&client_id=\(APIKey.unsplashId)"
        
        var imageList: [String] = []
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("JSON: \(json)")
                
                for image in json["results"].arrayValue {
                    imageList.append(image["urls"]["regular"].stringValue)
                }
                completionHandler(imageList)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
