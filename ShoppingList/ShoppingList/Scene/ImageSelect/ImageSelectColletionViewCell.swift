//
//  ImageSelectColletionViewCell.swift
//  ShoppingList
//
//  Created by 유연탁 on 2022/08/25.
//

import UIKit

class ImageSelctCollectionViewCell: BaseCollectionViewCell {
    
    let itemImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    override func configureUI() {
        self.addSubview(itemImageView)
    }
    
    override func setContstraints() {
        
        itemImageView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(self)
        }
    }
}
