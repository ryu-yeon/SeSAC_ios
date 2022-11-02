//
//  LoginView.swift
//  SeSacNetwork2
//
//  Created by 유연탁 on 2022/11/03.
//

import UIKit

import SnapKit

class LoginView: BaseView {
    
    let emailTextField: UITextField = {
        let view = UITextField()
        view.borderStyle = .line
        view.placeholder = "이메일을 입력해주세요."
        view.text = "yt123456@naver.com"
        return view
    }()
    
    let passwordTextField: UITextField = {
        let view = UITextField()
        view.borderStyle = .line
        view.placeholder = "비밀번호를 입력해주세요."
        return view
    }()
    
    let loginButton: UIButton = {
        let view = UIButton()
        view.setTitle("로그인", for: .normal)
        view.backgroundColor = .lightGray
        return view
    }()
    
    let signupButton: UIButton = {
        let view = UIButton()
        view.setTitle("회원가입", for: .normal)
        view.backgroundColor = .lightGray
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .systemBackground
        [emailTextField, passwordTextField, loginButton, signupButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
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
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(40)
            make.centerX.equalTo(self)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        
        signupButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(40)
            make.centerX.equalTo(self)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
    }
}
