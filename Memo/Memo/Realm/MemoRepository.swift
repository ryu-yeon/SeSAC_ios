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

class MemoRepository {
    
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
            print("실패🔴🔴🔴", #function)
        }
    }

    func deleteMemo(memo: Memo) {
        do {
            try localRealm.write {
                localRealm.delete(memo)
            }
        } catch {
            print("실패🔴🔴🔴", #function)
        }
    }
    
    func saveMemo(folder: Folder, title: String, content: String?) {
        do {
            try localRealm.write {
                let memo = Memo(title: title, content: content, registerDate: Date(), isFixed: false)
                folder.memo.append(memo)
            }
        } catch {
            print("실패🔴🔴🔴", #function)
        }
    }
    
    func updateMemo(memo: Memo?, title: String, content: String?) {
        do {
            try localRealm.write {
                memo?.title = title
                memo?.content = content
                memo?.registerDate = Date()
            }
        } catch {
            print("실패🔴🔴🔴", #function)
        }
    }
    
    func sortMemo(list: List<Memo>) {
        do {
            try localRealm.write {
                for start in 0..<list.count - 1 {
                    var min = start
                    for index in start+1..<list.count {
                        if list[start].registerDate < list[index].registerDate {
                            min = index
                        }
                    }
                    list.swapAt(start, min)
                }
            }
        } catch {
            print("실패🔴🔴🔴", #function)
        }
    }
}
