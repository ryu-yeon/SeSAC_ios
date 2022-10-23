//
//  MigrationViewController.swift
//  FireBaseExample
//
//  Created by 유연탁 on 2022/10/13.
//

import UIKit

import RealmSwift

class MigrationViewController: UIViewController {

    let localRealm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1. fileURL
        print("FileURL: \(localRealm.configuration.fileURL!)")
        
        //2. SchemaVersion
        do {
            let version = try schemaVersionAtURL(localRealm.configuration.fileURL!)
            print("Schema Version: \(version)")
        } catch {
            print(error)
        }
        
//        //3. Test
//        for i in 1...100 {
//            let task = Todo(title: "고래바의 할일 \(i)", importance: Int.random(in: 1...5))
//
//            try! localRealm.write {
//                localRealm.add(task)
//            }
//        }
//        //4. DetailTodo
//        for i in 1...10 {
//            let task = DetailTodo(detailTitle: "양파\(i)개 사기", favorite: true)
//
//            try! localRealm.write {
//                localRealm.add(task)
//            }
//        }
        
//        //특정 Todo 테이블에 DetailTodo 추가
//        guard let task = localRealm.objects(Todo.self).filter("title = '고래바의 할일 2'").first else { return }
//
//        let detail = DetailTodo(detailTitle: "깡깡한 아이스크림 먹기", favorite: false)
//
//        try! localRealm.write {
//            task.detail.append(detail)
//        }
        
//        //특정 Todo 테이블 삭제
//        guard let task = localRealm.objects(Todo.self).filter("title = '고래바의 할일 2'").first else { return }
//
//        try! localRealm.write {
//            localRealm.delete(task.detail)
//            localRealm.delete(task)
//        }
        
//        //특정 Todo에 메모 추가
//        guard let task = localRealm.objects(Todo.self).filter("title = '고래바의 할일 4'").first else { return }
//
//        let memo = Memo(content: "이렇게 메모 내용을 추가해봅니다.", date: Date())
//
//        try! localRealm.write {
//            task.memo = memo
//        }
    }
}
