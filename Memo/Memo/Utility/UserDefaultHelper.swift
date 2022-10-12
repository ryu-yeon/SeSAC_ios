//
//  UserDefaultHelper.swift
//  Memo
//
//  Created by 유연탁 on 2022/09/05.
//

import Foundation

enum Key: String {
    case start
}

public class UserDefaultHelper {
    private init() {}
    
    public static var standard = UserDefaultHelper()
    
    private let userDefault = UserDefaults.standard
    
    public var start: Bool {
        get {
            return userDefault.bool(forKey: Key.start.rawValue)
        }
        set {
            userDefault.set(newValue, forKey: Key.start.rawValue)
        }
    }
    
}
