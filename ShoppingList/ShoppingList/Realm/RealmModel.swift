//
//  RealmModel.swift
//  ShoppingList
//
//  Created by 유연탁 on 2022/08/23.
//

import Foundation

import RealmSwift

class ShoppingList: Object {
    @Persisted var shoppingItem: String
    @Persisted var checkItem: Bool
    @Persisted var favoriteItem: Bool
    @Persisted var registerDate = Date()
    
    @Persisted(primaryKey: true) var ObjectId: ObjectId
    
    convenience init(shoppingItem: String, checkItem: Bool, favoriteItem: Bool, registerDate: Date) {
        self.init()
        self.shoppingItem = shoppingItem
        self.checkItem = false
        self.favoriteItem = false
        self.registerDate = Date()
    }
}
