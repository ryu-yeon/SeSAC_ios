//
//  MemoListViewModel.swift
//  Memo
//
//  Created by 유연탁 on 2022/10/27.
//

import Foundation

import RealmSwift
import RxCocoa
import RxDataSources
import RxSwift

struct SectionOfCustomData {
  var header: String
  var items: [Item]
}

extension SectionOfCustomData: SectionModelType {
    typealias Item = Memo
    
    init(original: SectionOfCustomData, items: [Item]) {
        self = original
        self.items = items
    }
}
    

class MemoListViewModel {
    
    let list = PublishSubject<Folder>()
    let memoList = PublishSubject<[SectionOfCustomData]>()
    let memoRepository = MemoRepository()
    
    var data: [SectionOfCustomData] = []
    
    var folder: Folder!
    
    func fetch() {
        memoRepository.sortMemo(list: folder.memo)
        list.onNext(folder)
        memoListfilter()
        memoList.onNext(data)
    }
    
    func memoListfilter() {
        data.removeAll()
        if !(folder.memo.filter({ $0.isFixed == true}).isEmpty) {
            data.append(SectionOfCustomData(header: "고정된 메모", items: folder.memo.filter { $0.isFixed == true}))
        }
        if !(folder.memo.filter({ $0.isFixed == false}).isEmpty) {
            data.append(SectionOfCustomData(header: "메모", items: folder.memo.filter { $0.isFixed == false}))
        }
    }
    
    func removeMemo(indexPath: IndexPath) {
        memoRepository.deleteMemo(memo: data[indexPath.section].items[indexPath.row])
        memoListfilter()
        memoList.onNext(data)
    }
    
    func fixMemo(indexPath: IndexPath) {
        memoRepository.updateIsFixed(memo: data[indexPath.section].items[indexPath.row])
        memoListfilter()
        memoList.onNext(data)
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
