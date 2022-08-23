//
//  ShoppingListTableViewCell.swift
//  ShoppingList
//
//  Created by 유연탁 on 2022/08/22.
//

import UIKit

import RealmSwift
import SnapKit

class ShoppingListTableViewCell: BaseTableViewCell {
    
    let checkButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        view.contentVerticalAlignment = .fill
        view.contentHorizontalAlignment = .fill
        view.tintColor = .black
        return view
    }()
    
    let shoppingListLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.font = .boldSystemFont(ofSize: 28)
        view.textColor = .black
        return view
    }()
    
    let favoriteButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "star"), for: .normal)
        view.contentVerticalAlignment = .fill
        view.contentHorizontalAlignment = .fill
        view.tintColor = .black
        return view
    }()
    
    override func configureUI() {
        [checkButton, shoppingListLabel, favoriteButton].forEach {
            self.addSubview($0)
        }
        
        [checkButton, favoriteButton].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        checkButton.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.leading.equalTo(self).offset(16)
            make.height.width.equalTo(self.snp.height).multipliedBy(0.5)
            make.trailing.equalTo(shoppingListLabel.snp.leading).offset(-20)
        }
        
        shoppingListLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.leading.equalTo(checkButton.snp.trailing)
            make.trailing.equalTo(favoriteButton.snp.leading)
            make.height.equalTo(self.snp.height).multipliedBy(0.8)
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.trailing.equalTo(self).offset(-16)
            make.height.width.equalTo(checkButton.snp.height)
        }
    }
}
