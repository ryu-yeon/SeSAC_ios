//
//  FolderListViewModel.swift
//  Memo
//
//  Created by 유연탁 on 2022/10/27.
//

import Foundation

import RealmSwift
import RxCocoa
import RxSwift

class FolderListViewModel {
    
    let list = PublishSubject<Results<Folder>>()
    
    private let folderRepository = FolderRepository()
    
    var tasks: Results<Folder>!
    
    func fetch() {
        tasks = folderRepository.fetchFolder()
        list.onNext(tasks)
    }
    
    func removeFolder(index: Int) {
        folderRepository.removeFolder(folder: tasks[index])
        list.onNext(tasks)
    }
    
    func saveFolder() {
        folderRepository.saveFolder(title: "메모")
    }
    
}
