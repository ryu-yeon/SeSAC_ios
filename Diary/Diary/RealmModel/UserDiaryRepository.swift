//
//  UserDiaryRepository.swift
//  Diary
//
//  Created by 유연탁 on 2022/08/26.
//

import UIKit

import RealmSwift

protocol UserDiaryRepositoryType {
    func fetch() -> Results<UserDiary>
    func fetchSort(_ sort: String) -> Results<UserDiary>
    func fetchFilter() -> Results<UserDiary>
    func fetchDate(date: Date) -> Results<UserDiary>
    func updateFavorite(task: UserDiary)
    func deleteTask(task: UserDiary)
    func addItem(item: UserDiary)
}

class UserDiaryRepository: UserDiaryRepositoryType {

    let localRealm = try! Realm()
    
    func addItem(item: UserDiary) {
        
    }
    
    func fetchDate(date: Date) -> Results<UserDiary> {
        return localRealm.objects(UserDiary.self).filter("diaryDate >= %@ AND diaryDate < %@", date, Date(timeInterval: 86400, since: date)) //NSpredicate
    }
    
    
    func fetch() -> Results<UserDiary> {
        return localRealm.objects(UserDiary.self).sorted(byKeyPath: "diaryTitle", ascending: true)
    }
    
    func fetchSort(_ sort: String) -> Results<UserDiary> {
        return localRealm.objects(UserDiary.self).sorted(byKeyPath: sort, ascending: true)
    }
    
    func fetchFilter() -> Results<UserDiary> {
        return localRealm.objects(UserDiary.self).sorted(byKeyPath: "diaryTitle CONTAINS[c] '일기'")
    }
    
    func updateFavorite(task: UserDiary) {
        try! localRealm.write {
            task.favorite = !task.favorite
        }
    }
    
    func deleteTask(task: UserDiary) {
        
        removeImageFromDocument(fileName: "\(task.objectId).jpg")
        
        try! localRealm.write {
            localRealm.delete(task)
        }
    }
    
    func removeImageFromDocument(fileName: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return } // 내 앱에 해당되는 도큐먼트 폴더가 있늬?
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch let error {
            print(error)
        }
    }
    
}
