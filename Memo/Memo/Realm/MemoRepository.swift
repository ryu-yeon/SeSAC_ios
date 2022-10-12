//
//  MemoRepository.swift
//  Memo
//
//  Created by 유연탁 on 2022/09/05.
//

import Foundation

import RealmSwift

protocol MemoRepositoryType {
    func fetchSort(sort: String) -> Results<Memo>
    func fetchFiter(text: String) -> Results<Memo>
    func fetchFiterSort(text: String, sort: String) -> Results<Memo>
    func updateIsFixed(task: Memo)
    func deleteTask(task: Memo)
    func saveTask(title: String, content: String?)
    func updateTask(task: Memo?, title: String, content: String?)
}

class MemoRepository: MemoRepositoryType {
    
    let localRealm = try! Realm()
    
    func fetchSort(sort: String) -> Results<Memo> {
        return localRealm.objects(Memo.self).sorted(byKeyPath: sort, ascending: true)
    }
    
    func fetchFiter(text: String) -> Results<Memo> {
        return localRealm.objects(Memo.self).filter(text)
    }
    
    func fetchFiterSort(text: String, sort: String) -> Results<Memo> {
        return localRealm.objects(Memo.self).filter(text).sorted(byKeyPath: sort, ascending: true)
    }
    
    func updateIsFixed(task: Memo) {
        do {
            try localRealm.write {
                task.isFixed = !task.isFixed
            }
        } catch {
            print("실패", #function)
        }
    }

    func deleteTask(task: Memo) {
        do {
            try localRealm.write {
                localRealm.delete(task)
            }
        } catch {
            print("실패", #function)
        }
    }
    
    func saveTask(title: String, content: String?) {
        do {
            try localRealm.write {
                let task = Memo(title: title, content: content, registerDate: Date(), isFixed: false)
                localRealm.add(task)
            }
        } catch {
            print("실패", #function)
        }
    }
    
    func updateTask(task: Memo?, title: String, content: String?) {
        do {
            try localRealm.write {
                task?.title = title
                task?.content = content
                task?.registerDate = Date()
            }
        } catch {
            print("실패", #function)
        }
    }
}
