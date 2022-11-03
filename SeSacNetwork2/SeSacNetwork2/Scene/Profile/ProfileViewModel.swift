//
//  ProfileViewModel.swift
//  SeSacNetwork2
//
//  Created by 유연탁 on 2022/11/03.
//

import Foundation

import RxCocoa
import RxSwift

final class ProfileViewModel {
    
    var profile = PublishSubject<Profile>()
    
    func fetchProfile() {
        let api = SeSACAPI.profile
        Network.shared.requestSeSAC(type: Profile.self, url: api.url, method: .get, headers: api.headers) {[weak self] response in
            switch response {
            case .success(let success):
                self?.profile.onNext(success)
            case .failure(let failure):
                self?.profile.onError(failure)
            }
        }
    }
}
