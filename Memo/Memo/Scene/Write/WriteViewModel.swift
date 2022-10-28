//
//  WriteViewModel.swift
//  Memo
//
//  Created by 유연탁 on 2022/10/28.
//

import Foundation

import RxCocoa
import RxSwift

class WriteViewModel {
    
    let list = PublishSubject<Memo>()
    var memo: Memo!
    var folder: Folder!
    private let memoRepository = MemoRepository()

    func fetch() {
        guard let memo else { return }
        list.onNext(memo)
    }
    
    func writeMemo(memoText: String) {
        var titleText = ""
        var contentText: String?
        var contentArray: [String] = []
        
        contentArray = memoText.split(separator: "\n").map{String($0)}
        if contentArray.count > 1 {
            titleText = contentArray[0]
            let startIndex = memoText.index(memoText.startIndex, offsetBy: titleText.count + 1)
            contentText = String(memoText[startIndex...])
        } else if contentArray.count == 0 {
            if let memo {
                memoRepository.deleteMemo(memo: memo)
            }
        } else {
            titleText = contentArray[0]
        }
        
        if contentArray.count > 0 {
            if let memo {
                memoRepository.updateMemo(memo: memo, title: titleText, content: contentText ?? "")
            } else {
                memoRepository.saveMemo(folder: folder, title: titleText, content: contentText)
            }
        }
    }
    
}
