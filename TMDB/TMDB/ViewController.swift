//
//  ViewController.swift
//  TMDB
//
//  Created by 유연탁 on 2022/08/03.
//

import UIKit

import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        requestTMDB()
    }

    func requestTMDB() {
        let url = EndPoint.URL + "/all/day?api_key=" + APIKey.TMDB
        AF.request(url, method: .get).validate().responseJSON { response in
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

