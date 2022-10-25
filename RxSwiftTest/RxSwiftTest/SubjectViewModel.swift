//
//  SubjectViewModel.swift
//  RxSwiftTest
//
//  Created by 유연탁 on 2022/10/25.
//

import Foundation

import RxCocoa
import RxSwift

struct Contact {
    var name: String
    var age: Int
    var number: String
}

class SubjectViewModel {

    
    var ContactData = [
        Contact(name: "Jack", age: 21, number: "01012341234"),
        Contact(name: "MetaVerse Jack", age: 23, number: "01012341234"),
        Contact(name: "Real Jack", age: 25, number: "01012341234")
    ]
    
    var list = PublishSubject<[Contact]>()
    
    func fetchData() {
        list.onNext(ContactData)
    }
    
    func resetData() {
        list.onNext([])
    }
    
    func addData() {
        
    }
    
    func newData() {
        let new = Contact(name: "고래밥", age: Int.random(in: 10...50), number: "")
        ContactData.append(new)
        list.onNext(ContactData)
    }
    
    func filterData(query: String) {
        let result = query != "" ? ContactData.filter { $0.name.contains(query) } : ContactData
        list.onNext(result)
    }
}
