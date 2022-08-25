//
//  SettingView.swift
//  ShoppingList
//
//  Created by 유연탁 on 2022/08/25.
//

import UIKit

import SnapKit

class SettingView: BaseView {
    
    let backupButton: UIButton = {
        let view = UIButton()
        view.setTitle("백업", for: .normal)
        view.backgroundColor = .gray
        view.tintColor = .white
        return view
    }()
    
    let restoreButton: UIButton = {
        let view = UIButton()
        view.setTitle("복원", for: .normal)
        view.backgroundColor = .gray
        view.tintColor = .white
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .white
        [backupButton, restoreButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        backupButton.snp.makeConstraints { make in
            make.top.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.width.height.equalTo(40)
        }
        
        restoreButton.snp.makeConstraints { make in
            make.top.equalTo(backupButton.snp.bottom).offset(20)
            make.leading.equalTo(20)
            make.width.height.equalTo(40)
        }
    }
}
