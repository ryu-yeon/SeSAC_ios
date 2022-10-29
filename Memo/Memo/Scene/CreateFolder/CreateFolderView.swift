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
        view.text = "새로운 폴더"
        view.clearButtonMode = .always
        view.tintColor = .pointColor
        return view
    }()
    
    let viewContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .viewBackgroundColor
        view.layer.cornerRadius = 8
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .backgroundColor
        [viewContainer, userTextField].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        viewContainer.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalTo(self).inset(20)
            make.height.equalTo(50)
        }
        userTextField.snp.makeConstraints { make in
            make.centerY.equalTo(viewContainer)
            make.leading.trailing.equalTo(viewContainer).inset(16)
            make.height.equalTo(40)
        }
    }
}
