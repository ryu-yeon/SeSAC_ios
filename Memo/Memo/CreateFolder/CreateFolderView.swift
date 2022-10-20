//
//  CreateFolderView.swift
//  Memo
//
//  Created by 유연탁 on 2022/10/20.
//

import UIKit

import SnapKit

class CreateFoderView: BaseView {
    
    let userTextField: UITextField = {
        let view = UITextField()
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .backgroundColor
        [userTextField].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        userTextField.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalTo(self).inset(20)
        }
    }
}
