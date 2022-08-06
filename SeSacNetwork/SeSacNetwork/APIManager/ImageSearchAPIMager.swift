//
//  ImageSearchAPIMager.swift
//  SeSacNetwork
//
//  Created by 유연탁 on 2022/08/05.
//

import Foundation

import Alamofire
import SwiftyJSON

//클래스 싱글턴 패턴 vs 구조체 싱글던 패턴
class ImageSearchAPIManager {
    
    static let shared = ImageSearchAPIManager()
    
    private init() {}
    
    typealias completionHandler = (Int, [String]) -> Void
    
    //non-escaping => @escaping
    func fetchImageData(query: String, startPage: Int, completionHandler: @escaping completionHandler) {
        
        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = EndPoint.imageSearchURL+"query=\(text)&display=30&start=\(startPage)&sort=sim"
        
        let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_ID, "X-Naver-Client-Secret": APIKey.NAVER_SECRET]
        
        AF.request(url, method: .get, headers: header).validate().responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("JSON: \(json)")
                
                let totalCount = json["total"].intValue
                
                let list = json["items"].arrayValue.map { $0["link"].stringValue }
                

//                for image in json["items"].arrayValue {
//
//                    self.list.append(image["link"].stringValue)
//                }
                
                
                completionHandler(totalCount, list)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
