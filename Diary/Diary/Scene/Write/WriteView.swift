//
//  WriteView.swift
//  Diary
//
//  Created by 유연탁 on 2022/08/21.
//

import UIKit

import SnapKit

class WriteView: BaseView {
    
    let userImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let addImageButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "photo"), for: .normal)
        view.clipsToBounds = true
//        view.layer.borderColor = UIColor.gray.cgColor
//        view.layer.borderWidth = 1
        view.tintColor = .white
        view.backgroundColor = .red
        return view
    }()
    
    let titleTextField: UITextField = {
        let view = UITextField()
        view.textAlignment = .center
        view.borderStyle = .line
        view.placeholder = "제목을 입력해주세요."
        return view
    }()
    
    let userTextField: UITextField = {
        let view = UITextField()
        view.textAlignment = .center
        view.borderStyle = .line
        view.placeholder = "입력해주세요."
        return view
    }()
    
    let userTextView: UITextView = {
        let view = UITextView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.backgroundColor = .white
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .white
        [userImageView, addImageButton, titleTextField, userTextField, userTextView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        userImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(self).multipliedBy(0.3)
        }
        
        addImageButton.snp.makeConstraints { make in
            make.bottom.equalTo(userImageView.snp.bottom).inset(16)
            make.trailing.equalTo(userImageView.snp.trailing).inset(16)
            make.width.height.equalTo(userImageView.snp.height).multipliedBy(0.15)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(userImageView.snp.bottom).offset(20)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(self).multipliedBy(0.05)
        }
        
        userTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(20)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(self).multipliedBy(0.05)
        }
        
        userTextView.snp.makeConstraints { make in
            make.top.equalTo(userTextField.snp.bottom).offset(20)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-20)
        }
    }
}

