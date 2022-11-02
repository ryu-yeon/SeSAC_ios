//
//  ProfileViewModel.swift
//  SeSacNetwork2
//
//  Created by 유연탁 on 2022/11/03.
//

import Foundation

import RxCocoa
import RxSwift

class ProfileViewModel {
    
    var list = PublishSubject<Profile>()
    
    var profile: Profile?
    
    func fetch() {
        APIService().profile { [weak self] profile in
            self?.profile = profile
            self?.list.onNext(profile)
        }
    }
}
