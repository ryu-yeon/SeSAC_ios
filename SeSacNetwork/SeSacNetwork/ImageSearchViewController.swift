//
//  ImageSearchViewController.swift
//  SeSacNetwork
//
//  Created by 유연탁 on 2022/08/03.
//

import UIKit

import Alamofire
import SwiftyJSON

class ImageSearchViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchImage()
    }
    
    //fetchImage, requestImage, callREquestImage, getImage...
    func fetchImage() {
        
        
        let text = "과자".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = EndPoint.imageSearchURL+"query=\(text)&display=30&start=1&sort=sim"
        
        let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_ID, "X-Naver-Client-Secret": APIKey.NAVER_SECRET]
        
        AF.request(url, method: .get, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
            case .failure(let error):
                print(error)
            }
        }
    }

}
