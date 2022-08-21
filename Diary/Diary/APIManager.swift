//
//  APIManager.swift
//  Diary
//
//  Created by 유연탁 on 2022/08/22.
//

import UIKit

import Alamofire
import SwiftyJSON

class APIManager {
    
    static let shared = APIManager()
    
    private init() {}
    
    func requestImage(_ text: String, completionHandler: @escaping ([String]) -> Void) {
        let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = EndPoint.naverSearch + "query=\(query)"
        let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.naverId, "X-Naver-Client-Secret": APIKey.naverPw]
        
        var imageList: [String] = []
        AF.request(url, method: .get, headers: header).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("JSON: \(json)")
                
                for image in json["items"].arrayValue {
                    imageList.append(image["link"].stringValue)
                }
                completionHandler(imageList)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
