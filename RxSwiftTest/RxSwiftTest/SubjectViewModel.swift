//
//  SubjectViewModel.swift
//  RxSwiftTest
//
//  Created by 유연탁 on 2022/10/25.
//

import Foundation

import RxCocoa
import RxSwift

//associated type == generic
protocol CommonViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

struct Contact {
    var name: String
    var age: Int
    var number: String
}

class SubjectViewModel: CommonViewModel {
    
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
    
    struct Input {
        let addTap: ControlEvent<Void>
        let resetTap: ControlEvent<Void>
        let newTap: ControlEvent<Void>
        let searchText: ControlProperty<String?>
    }
    
    struct Output {
        let addTap: ControlEvent<Void>
        let resetTap: ControlEvent<Void>
        let newTap: ControlEvent<Void>
        let list: PublishSubject<[Contact]>
        let searchText: Observable<String>
    }
    
    func transform(input: Input) -> Output {
        let list = list
        
        let text = input.searchText
            .orEmpty
            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
        
        return Output(addTap: input.addTap, resetTap: input.resetTap, newTap: input.newTap, list: list, searchText: text)
    }
}
