//
//  ValidationViewModel.swift
//  RxSwiftTest
//
//  Created by 유연탁 on 2022/10/27.
//

import Foundation

import RxCocoa
import RxSwift

class ValidationViewModel {
    
    let validText = BehaviorRelay(value: "닉네임은 최소 8자 이상 필요해요")
    
}
