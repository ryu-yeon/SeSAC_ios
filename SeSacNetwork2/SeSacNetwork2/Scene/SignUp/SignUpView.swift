//
//  SignUpView.swift
//  SeSacNetwork2
//
//  Created by 유연탁 on 2022/11/03.
//

import UIKit

import SnapKit

class SignUpView: BaseView {
    
    let usernameTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "이름을 입력해주세요."
        view.borderStyle = .line
        return view
    }()
    
    let emailTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "이메일을 입력해주세요."
        view.borderStyle = .line
        return view
    }()
    
    let passwordTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "비밀번호를 입력해주세요."
        view.borderStyle = .line
        return view
    }()
    
    let signupButton: UIButton = {
        let view = UIButton()
        view.setTitle("회원가입", for: .normal)
        view.setTitleColor(.brown, for: .highlighted)
        view.backgroundColor = .lightGray
        view.isEnabled = false
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .systemBackground
        [usernameTextField, emailTextField, passwordTextField, signupButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.centerX.equalTo(self)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(20)
            make.centerX.equalTo(self)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.centerX.equalTo(self)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        
        signupButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(40)
            make.centerX.equalTo(self)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
    }
}
