//
//  FolderRepository.swift
//  Memo
//
//  Created by 유연탁 on 2022/10/28.
//

import Foundation

import RealmSwift

class FolderRepository {
    
    let localRealm = try! Realm()
    
    func fetchFolder() -> Results<Folder> {
        print("Realm is located at:", localRealm.configuration.fileURL!)
        return localRealm.objects(Folder.self)
    }
    
    func saveFolder(title: String) {
        do {
            try localRealm.write {
                let folder = Folder(title: title)
                localRealm.add(folder)
            }
        } catch {
            print("실패🔴🔴🔴", #function)
        }
    }
    
    func removeFolder(folder: Folder) {
        do {
            try localRealm.write {
                localRealm.delete(folder)
            }
        } catch {
            print("실패🔴🔴🔴", #function)
        }
    }
    
}
