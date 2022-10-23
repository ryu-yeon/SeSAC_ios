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
    @Persisted var importance: Int
    @Persisted var detail: List<DetailTodo>
    @Persisted var memo: Memo? //EmbeddedObject는 항상 Optional
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(title: String, importance: Int) {
        self.init()
        self.title = title
        self.importance = importance
    }
}

class DetailTodo: Object {
    @Persisted var detailTitle: String
    @Persisted var favorite: Bool
    @Persisted var deadline: Date
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(detailTitle: String, favorite: Bool, deadline: Date) {
        self.init()
        self.detailTitle = detailTitle
        self.favorite = favorite
        self.deadline = deadline
    }
}

class Memo: EmbeddedObject {
    @Persisted var content: String
    @Persisted var date: Date
    
    convenience init(content: String, date: Date) {
        self.init()
        self.content = content
        self.date = date
    }
}
