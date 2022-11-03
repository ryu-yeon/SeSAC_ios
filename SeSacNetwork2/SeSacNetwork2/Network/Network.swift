//
//  Network.swift
//  SeSacNetwork2
//
//  Created by 유연탁 on 2022/11/03.
//

import Foundation

import Alamofire

final class Network {
    
    static let shared = Network()
    
    private init() { }
    
    func requestSeSAC<T: Decodable>(type: T.Type = T.self, url: URL, method: HTTPMethod, paraneters: [String: String]? = nil, headers: HTTPHeaders, complitionHandler: @escaping (Result<T, Error>) -> (Void)) {
        
        AF.request(url, method: method, parameters: paraneters, headers: headers)
            .responseDecodable(of: T.self) { response in
                
                switch response.result {
                    
                case .success(let data):
                    complitionHandler(.success(data))
                case .failure(_):
                    
                    guard let statusCode = response.response?.statusCode else { return }
                    guard let error = SeSACError(rawValue: statusCode) else { return }
                    complitionHandler(.failure(error))
                }
            }
    }
}
