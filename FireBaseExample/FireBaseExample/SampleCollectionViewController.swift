//
//  SampleCollectionViewController.swift
//  FireBaseExample
//
//  Created by 유연탁 on 2022/10/18.
//

import UIKit

import RealmSwift

class SampleCollectionViewController: UICollectionViewController {
    
    var tasks: Results<Todo>!
    let localRealm = try! Realm()
    
    var cellRegisteration: UICollectionView.CellRegistration<UICollectionViewListCell, Todo>!
    
    var hello: (() -> Void)!
    
    func welcome() {
        print("hello")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        hello = welcome
        
        tasks = localRealm.objects(Todo.self)
        
        collectionView.collectionViewLayout = createLayout() //UICollectionViewLayout

        cellRegisteration = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
            
            var content = cell.defaultContentConfiguration()
            content.image = itemIdentifier.importance < 2 ? UIImage(systemName: "person.fill") : UIImage(systemName: "person.2.fill")
            content.text = itemIdentifier.title
            content.secondaryText = "\(itemIdentifier.detail.count)개의 세부항목"
            
            cell.contentConfiguration = content
            
            var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
            backgroundConfig.backgroundColor = .lightGray
            backgroundConfig.cornerRadius = 10
            backgroundConfig.strokeColor = .systemPink
            backgroundConfig.strokeWidth = 2
            
            cell.backgroundConfiguration = backgroundConfig
        })
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = tasks[indexPath.item]
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegisteration, for: indexPath, item: item)
        return cell
    }
}

extension SampleCollectionViewController {
    private func createLayout() -> UICollectionViewLayout{
        //14+ 컬렉션뷰를 테이블뷰 스타일처럼 사용 가능 (List Configuration)
        //컬렉션뷰 스타일 (컬렉션뷰 셀 X)
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.backgroundColor = .brown
        configuration.showsSeparators = false
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration) //UICollectionViewConpositionalLayout
        
        return layout
    }
}


