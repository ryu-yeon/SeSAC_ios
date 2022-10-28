//
//  MemoListViewModel.swift
//  Memo
//
//  Created by 유연탁 on 2022/10/27.
//

import Foundation

import RealmSwift
import RxCocoa
import RxSwift

class MemoListViewModel {
    
    let list = PublishSubject<Folder>()
    let memoList = PublishSubject<List<Memo>>()
    
    let memoRepository = MemoRepository()
    
    var folder: Folder!
    
    func fetch() {
        list.onNext(folder)
        memoList.onNext(folder.memo)
    }
    
    func removeMemo(index: Int) {
        memoRepository.deleteMemo(memo: folder.memo[index])
        memoList.onNext(folder.memo)
    }
}
