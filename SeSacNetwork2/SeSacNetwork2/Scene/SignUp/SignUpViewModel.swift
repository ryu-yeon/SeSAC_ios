//
//  SignUpViewModel.swift
//  SeSacNetwork2
//
//  Created by 유연탁 on 2022/11/03.
//

import Foundation

import RxCocoa
import RxSwift

class SignUpViewModel {
    
    var username = ""
    var email = ""
    var password = ""
    
    func signButtonEnable() -> Bool {
        if username != "" && email != "" && password != "" {
            return true
        }
        else {
            return false
        }
    }
}
