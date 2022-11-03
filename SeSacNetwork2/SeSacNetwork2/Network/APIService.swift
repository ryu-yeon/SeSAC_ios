//
//  APIService.swift
//  SeSacNetwork2
//
//  Created by 유연탁 on 2022/11/02.
//

import Foundation

import Alamofire

enum SeSACError: Int, Error {
    case invalidAuthorization = 401
    case takenEmail = 406
    case emptyParameters = 530
}

extension SeSACError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .invalidAuthorization:
            return "토큰이 만료되었습니다. 다시 로그인 해주세."
        case .takenEmail:
            return "이미 가입된 회원입니다. 로그인 해주세요."
        case .emptyParameters:
            return "머가 없습니다."
        }
    }
}

class APIService {

    func signup(username: String, email: String, password: String) {
        let api = SeSACAPI.signup(userName: username, email: email, password: password)
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.headers).responseString { response in
            print(response)
            print(response.response?.statusCode)
        }
    }

    func login(email: String, password: String, complitionHandler: @escaping (Bool) -> Void) {
        let api = SeSACAPI.login(email: email, password: password)
        
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.headers)
            .validate(statusCode: 200...299)
            .responseDecodable(of: Login.self) { response in

            switch response.result {
            case .success(let data):
                print(data.token)
                UserDefaults.standard.set(data.token, forKey: "token")
                complitionHandler(true)
            case .failure(_):
                print(response.response?.statusCode)
                complitionHandler(false)
            }
        }
    }

    func profile(complitionHandler: @escaping (Profile) -> Void) {
        let api = SeSACAPI.profile
        AF.request(api.url, method: .get, headers: api.headers)
            .validate(statusCode: 200...299)
            .responseDecodable(of: Profile.self) { response in
                switch response.result {
                case .success(let data):
                    dump(data)
                    complitionHandler(data)
                case .failure(_):
                    print(response.response?.statusCode)
                }
            }
    }
    

}
