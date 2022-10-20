//
//  FolderListView.swift
//  Memo
//
//  Created by 유연탁 on 2022/10/20.
//

import UIKit

import SnapKit

class FolderListView: BaseView {
    let collectionView: UICollectionView = {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    let toolBar: UIToolbar = {
        let view = UIToolbar()
        view.barTintColor = .backgroundColor
        view.tintColor = .pointColor
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .backgroundColor
        [collectionView, toolBar].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalTo(self)
            make.bottom.equalTo(toolBar.snp.top)
        }
        
        toolBar.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.leading.trailing.equalTo(self)
            make.bottom.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.08)
        }
    }
}
