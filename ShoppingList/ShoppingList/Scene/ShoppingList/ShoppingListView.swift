//
//  ShoppingListView.swift
//  ShoppingList
//
//  Created by 유연탁 on 2022/08/22.
//

import UIKit

import SnapKit

class ShoppingListView: BaseView {
    

    let userTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "  입력해주세요"
        view.borderStyle = .line
        return view
    }()
    
    let addButton: UIButton = {
        let view = UIButton()
        view.setTitle("추가", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let tableView: UITableView = {
        let view = UITableView()
        view.separatorStyle = .singleLine
        view.separatorInset.left = 0
//        view.backgroundColor = .lightGray
        return view
    }()

    override func configureUI() {
        self.backgroundColor = .white
        [userTextField, addButton, tableView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        userTextField.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(36)
            make.leading.equalTo(20)
            make.trailing.equalTo(addButton.snp.leading)
            make.height.equalTo(40)
        }
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(userTextField.snp.top)
            make.leading.equalTo(userTextField.snp.trailing)
            make.trailing.equalTo(-20)
            make.width.equalTo(48)
            make.height.equalTo(userTextField.snp.height)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(userTextField.snp.bottom).offset(48)
            make.leading.equalTo(userTextField.snp.leading)
            make.trailing.equalTo(addButton.snp.trailing)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-20)
        }
    }
    
}
