//
//  ImageSelectView.swift
//  ShoppingList
//
//  Created by 유연탁 on 2022/08/25.
//

import UIKit

import SnapKit

class ImageSelectView: BaseView {
    
    let userSearchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "입력해주세요."
        return view
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - spacing * 4
        
        layout.itemSize = CGSize(width: width / 3, height: width / 3)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .vertical
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .white
        [userSearchBar, collectionView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        userSearchBar.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.trailing.leading.equalTo(0)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(userSearchBar.snp.bottom)
            make.leading.trailing.bottom.equalTo(0)
        }
    }
    
}
