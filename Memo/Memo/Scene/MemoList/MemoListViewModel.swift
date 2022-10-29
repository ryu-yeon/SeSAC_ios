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
    
    func setDateFormat(date: Date) -> String {
        
        let dateFormat: DateFormatter = {
            let format = DateFormatter()
            format.locale = Locale(identifier: "ko_KR")
            return format
        }()
        
        if Calendar.current.isDateInToday(date) {
            dateFormat.dateFormat = "a hh:mm"
            
        } else if NSCalendar.current.component(.weekOfYear, from: date) == NSCalendar.current.component(.weekOfYear, from: Date()) {
            dateFormat.dateFormat = "EEEE"
        } else {
            dateFormat.dateFormat = "yyyy. MM. dd a hh:mm"
        }
        return dateFormat.string(from: date)
    }
    
    func setNumberFormat(number: Int) -> String {
        let numberFormat: NumberFormatter = {
            let format = NumberFormatter()
            format.numberStyle = .decimal
            return format
        }()
        return (numberFormat.string(for: number) ?? "") + "개의 메모"
    }
}
