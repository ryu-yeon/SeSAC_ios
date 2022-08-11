//
//  TMDBAPIManager.swift
//  SeSacWeek6
//
//  Created by 유연탁 on 2022/08/10.
//

import Foundation

import Alamofire
import SwiftyJSON

class TMDBAPIManager {
    
    static let shared = TMDBAPIManager()
    
    private init() {}
    
    let tvList = [
        ("환혼", 135157),
        ("이상한 변호사 우영우", 197067),
        ("인사이더", 135655),
        ("미스터 션사인", 75820),
        ("스카이 캐슬", 84327),
        ("사랑의 불시착", 94796),
        ("이태원 클라스", 96162),
        ("호텔 델루나", 90447)
    ]
    
    let imageURL = "https://image.tmdb.org/t/p/w500"
    
    
    func callRequest(query: Int, completionHandler: @escaping ([String]) -> ())  {
        
        print(#function)
        let seasonURL = "https://api.themoviedb.org/3/tv/\(query)/season/1?api_key=\(APIKey.TMDB)&language=ko-KR"
        
        //Alamofire -> URLSession Framework -> 비동기로 Request
        AF.request(seasonURL, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
//                var list: [String] = []
//                for episode in json["episodes"].arrayValue {
//                    list.append(episode["still_path"].stringValue)
//                }
                
                let list = json["episodes"].arrayValue.map { $0["still_path"].stringValue }

                completionHandler(list)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestImage(completionHandler: @escaping ([[String]]) -> ()) {
        
        var posterList: [[String]] = []
        
        //나~~~중에 배울 것 : async/await(iOS13 이상)
        TMDBAPIManager.shared.callRequest(query: tvList[0].1) { value in
            posterList.append(value)

            TMDBAPIManager.shared.callRequest(query: self.tvList[1].1) { value in
                posterList.append(value)

                TMDBAPIManager.shared.callRequest(query: self.tvList[2].1) { value in
                    posterList.append(value)
                   
                    TMDBAPIManager.shared.callRequest(query: self.tvList[3].1) { value in
                        posterList.append(value)
                     
                        TMDBAPIManager.shared.callRequest(query: self.tvList[4].1) { value in
                            posterList.append(value)
                           
                            TMDBAPIManager.shared.callRequest(query: self.tvList[5].1) { value in
                                posterList.append(value)
                                
                                TMDBAPIManager.shared.callRequest(query: self.tvList[6].1) { value in
                                    posterList.append(value)
                                    
                                    TMDBAPIManager.shared.callRequest(query: self.tvList[7].1) { value in
                                        posterList.append(value)
                                        completionHandler(posterList)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
 /*
    func requestEpospodeImage() {
        
        //어떤 문제가 생길 수 있을까요?
        //1. 순서 보장X
        //2. 언제 끝날 지 모름
        //3. Limit
        for item in tvList {
            TMDBAPIManager.shared.callRequest(query: item.1) { list in
                dump(list)
            }
        }
        
        
//        let id = tvList[7].1 //90477
//
//        TMDBAPIManager.shared.callRequest(query: id) { list in
//
//            dump(list)
//            TMDBAPIManager.shared.callRequest(query: self.tvList[5].1) { list in
//
//                dump(list)
//            }
//        }
    }
}
*/
