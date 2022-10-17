//
//  Todo.swift
//  FireBaseExample
//
//  Created by 유연탁 on 2022/10/13.
//

import Foundation

import RealmSwift

class Todo: Object {
    @Persisted var title: String
    @Persisted var favorite: Double
    @Persisted var userDecription: String
    @Persisted var count: Int
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(title: String, favorite: Int) {
        self.init()
        self.title = title
        self.favorite = Double(favorite)
    }
}
