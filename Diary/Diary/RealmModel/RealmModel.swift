//
//  RealmModel.swift
//  Diary
//
//  Created by 유연탁 on 2022/08/24.
//

import Foundation

import RealmSwift

//UserDiary: 테이블 이름
//@Persisted: 컬럼

class UserDiary: Object {
    @Persisted var diaryTitle: String
    @Persisted var diaryContent: String?
    @Persisted var diaryDate = Date()
    @Persisted var registerDate = Date()
    @Persisted var favorite: Bool
    @Persisted var photo: String?

    //PK(필수): Int, UUID, ObjectId
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(diaryTitle: String, diaryContenet: String?, diaryDate: Date, registerDate: Date, favorite: Bool, photo: String?) {
        self.init()
        self.diaryTitle = diaryTitle
        self.diaryContent = diaryContenet
        self.diaryDate = diaryDate
        self.registerDate = registerDate
        self.favorite = false
        self.photo = photo
    }
}
