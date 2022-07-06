//
//  SignUpViewController.swift
//  Movie
//
//  Created by 유연탁 on 2022/07/06.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var idTextField: UITextField!
    
    
    
    
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var inputSwitch: UISwitch!
    @IBOutlet weak var registerButton: UIButton!
    
    var id: String = ""
    var password: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        idTextField.attributedPlaceholder = NSAttributedString(string: "이메일 주소 또는 전화번호", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .regular)])
        idTextField.textColor = .white
        idTextField.keyboardType = .emailAddress
        idTextField.textAlignment = .center
        idTextField.borderStyle = .roundedRect
        idTextField.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        idTextField.isSecureTextEntry = false
        idTextField.backgroundColor = .darkGray
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "비밀번호", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .regular)])
        passwordTextField.textColor = .white
        passwordTextField.textAlignment = .center
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        passwordTextField.isSecureTextEntry = true
        passwordTextField.backgroundColor = .darkGray
        
        nicknameTextField.attributedPlaceholder = NSAttributedString(string: "닉네임", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .regular)])
        nicknameTextField.textColor = .white
        nicknameTextField.textAlignment = .center
        nicknameTextField.borderStyle = .roundedRect
        nicknameTextField.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        nicknameTextField.isSecureTextEntry = false
        nicknameTextField.backgroundColor = .darkGray
        
        locationTextField.attributedPlaceholder = NSAttributedString(string: "위치", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .regular)])
        locationTextField.textColor = .white
        locationTextField.textAlignment = .center
        locationTextField.borderStyle = .roundedRect
        locationTextField.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        locationTextField.isSecureTextEntry = false
        locationTextField.backgroundColor = .darkGray
        
        codeTextField.attributedPlaceholder = NSAttributedString(string: "추천 코드 입력", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .regular)])
        codeTextField.textColor = .white
        codeTextField.textAlignment = .center
        codeTextField.borderStyle = .roundedRect
        codeTextField.keyboardType = .numberPad
        codeTextField.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        codeTextField.isSecureTextEntry = false
        codeTextField.backgroundColor = .darkGray
        
        registerButton.setTitle("회원가입", for: .normal)
        registerButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        registerButton.setTitleColor(.black, for: .normal)
        registerButton.backgroundColor = .white
        registerButton.layer.cornerRadius = 8
        
        
        inputSwitch.setOn(true, animated: true)
        inputSwitch.onTintColor = .red
        inputSwitch.thumbTintColor = .white
        inputSwitch.layer.cornerRadius = inputSwitch.frame.height / 2
        inputSwitch.backgroundColor = .darkGray
        
    }
    

    @IBAction func registerButtonClicked(_ sender: UIButton) {
        view.endEditing(true)
        id = idTextField.text ?? ""
        password = passwordTextField.text ?? ""
        if id != "" && password.count >= 6 {
            print("가능")
        } else {
            print("불가능")
        }

    }
    
    @IBAction func tapGestureClicked(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)

    }
    
}
