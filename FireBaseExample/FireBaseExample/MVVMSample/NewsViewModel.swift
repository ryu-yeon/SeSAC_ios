//
//  NewsViewModel.swift
//  FireBaseExample
//
//  Created by 유연탁 on 2022/10/20.
//

import Foundation

class NewsViewModel {
    
    var pageNumber: CObservable<String> = CObservable("3000")
    
    var sample: CObservable<[News.NewsItem]> = CObservable(News.items)
    
    func changePageNumberFormat(text: String) {
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        let text = text.replacingOccurrences(of: ",", with: "")
        guard let number = Int(text) else { return }
        let result = numberFormatter.string(for: number)!
        
        pageNumber.value = result
    }
    
    func resetSample() {
        sample.value = []
    }
    
    func loadSample() {
        sample.value = News.items
    }
}
