//
//  LottoAPIManager.swift
//  SeSacNetwork
//
//  Created by 유연탁 on 2022/08/07.
//

import UIKit

import Alamofire
import SwiftyJSON

class LottoAPIManager {
    
    static let shared = LottoAPIManager()
    
    private init() {}
    
    func requestLottoData(round: Int, completionHanlder: @escaping ([String], String) -> Void) {
        
        let url = "\(EndPoint.lottoURL)&drwNo=\(round)"
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                var winningNumbers: [String] = []
                
                for number in 1...6 {
                    winningNumbers.append(json["drwtNo\(number)"].stringValue)
                }
                let bonusNumber = json["bnusNo"].stringValue
                
                completionHanlder(winningNumbers, bonusNumber)
                
            case .failure(let error):
                print(error)
            }
        }
    
    }
    
}
