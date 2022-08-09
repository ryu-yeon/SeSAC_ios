//
//  KakaoAPIManager.swift
//  SeSacWeek6
//
//  Created by 유연탁 on 2022/08/08.
//

import Foundation

import Alamofire
import SwiftyJSON

class KakaoAPIManager {
    
    static let shared = KakaoAPIManager()
    
    private init() {}
    
    let headers: HTTPHeaders = ["Authorization": "KakaoAK \(APIKey.kakao)"]
    
    func callRequest(type: EndPoint, searchText: String, completionHandler: @escaping (JSON) -> ())  {
        
        guard let query = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let url = type.requestURL + query
        
        //Alamofire -> URLSession Framework -> 비동기로 Request
        AF.request(url, method: .get, headers: headers).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                completionHandler(json)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
