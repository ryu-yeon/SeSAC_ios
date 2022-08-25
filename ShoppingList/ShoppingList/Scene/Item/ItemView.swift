//
//  ItemView.swift
//  ShoppingList
//
//  Created by 유연탁 on 2022/08/24.
//

import UIKit

import SnapKit

class ItemView: BaseView {
    
    let itemLable: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 24)
        view.textColor = .black
        return view
    }()
    
    var dateLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 18)
        view.textColor = .black
        return view
    }()
    
    let checkButton: UIButton = {
        let view = UIButton()
        return view
    }()
    
    let favoriteButton: UIButton = {
        let view = UIButton()
        return view
    }()
    
    let detailTextView: UITextView = {
        let view = UITextView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    let itemImageView: UIImageView = {
       let view = UIImageView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let addImageButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "photo"), for: .normal)
        view.tintColor = .white
        view.backgroundColor = .red
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .white
        [itemLable, dateLabel, checkButton, favoriteButton, detailTextView, itemImageView, addImageButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        itemLable.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.leading.equalTo(safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(30)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(itemLable.snp.bottom).offset(16)
            make.leading.equalTo(itemLable.snp.leading)
            make.trailing.equalTo(itemLable.snp.trailing)
            make.height.equalTo(20)
        }
        
        detailTextView.snp.makeConstraints { make in
            make.top.equalTo(itemImageView.snp.bottom).offset(40)
            make.leading.equalTo(itemLable.snp.leading)
            make.trailing.equalTo(itemLable.snp.trailing)
            make.height.equalTo(200)
        }
        
        itemImageView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(20)
            make.leading.equalTo(itemLable.snp.leading)
            make.trailing.equalTo(itemLable.snp.trailing)
            make.height.equalTo(self).multipliedBy(0.3)
        }
        
        addImageButton.snp.makeConstraints { make in
            make.bottom.equalTo(itemImageView.snp.bottom).inset(20)
            make.trailing.equalTo(itemImageView.snp.trailing).inset(20)
            make.width.height.equalTo(40)
        }
    }
}
