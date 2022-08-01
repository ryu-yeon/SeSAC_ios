//
//  UserDefaultsHelper.swift
//  Tamagotchi
//
//  Created by 유연탁 on 2022/08/02.
//

import Foundation

enum Key: String {
    case nickname, start, tamagotchiNumber, data
}

class UserDefaultsHelper {
    
    private init()  { }
    
    static let standard = UserDefaultsHelper()
    
    let userDefault = UserDefaults.standard
    
    var nickname: String {
        get {
            return userDefault.string(forKey: Key.nickname.rawValue) ?? "대장님"
        }
        set {
            userDefault.set(newValue, forKey: Key.nickname.rawValue)
        }
    }
    
    var start: Bool {
        get {
            return userDefault.bool(forKey: Key.start.rawValue)
        }
        set {
            userDefault.set(newValue, forKey: Key.start.rawValue)
        }
    }
    
    var tamagotchiNumber: Int {
        get {
            return userDefault.integer(forKey: Key.tamagotchiNumber.rawValue)
        }
        set {
            userDefault.set(newValue, forKey: Key.tamagotchiNumber.rawValue)
        }
    }
    
    var data: [Int] {
        get {
            return userDefault.array(forKey: Key.data.rawValue) as? [Int] ?? [1, 0, 0]
        }
        set {
            userDefault.set(newValue, forKey: Key.data.rawValue)
        }
    }
}
