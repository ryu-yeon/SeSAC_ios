//
//  NewsViewModel.swift
//  RxSwiftTest
//
//  Created by 유연탁 on 2022/10/26.
//

import Foundation
import RxSwift
import RxRelay

class NewsViewModel {
    
    var pageNumber = BehaviorSubject<String>(value: "3,000")
    
    var sample = BehaviorRelay(value: News.items)
    
    func changePageNumberFormat(text: String) {
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        let text = text.replacingOccurrences(of: ",", with: "")
        guard let number = Int(text) else { return }
        let result = numberFormatter.string(for: number)!
        
        pageNumber.onNext(result)
        
    }
    
    func resetSample() {
        sample.accept([])
    }
    
    func loadSample() {
        sample.accept(News.items)
    }
}
