//
//  DiffableViewModel.swift
//  RxSwiftTest
//
//  Created by 유연탁 on 2022/10/26.
//

import Foundation
import RxSwift

enum SearchError: Error {
    case noPhoto
    case serverError
}


class DiffableViewModel {
    
    var photoList = PublishSubject<SearchPhoto>()
    
    func requestSearchPhoto(query: String) {
        APIService.searchPhoto(query: query) { [weak self] photo, statusCode, error in
            
            guard let statusCode = statusCode, statusCode != 500 else {
                self?.photoList.onError(SearchError.serverError)
                return
            }
            
            guard let photo = photo else {
                self?.photoList.onError(SearchError.noPhoto)
                return
            }
            
            self?.photoList.onNext(photo)
        }
    }
}
