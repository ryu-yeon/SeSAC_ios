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
        
        designTextField(idTextField, text: "이메일 주소 또는 전화번호", keyboardType: .emailAddress, secure: false)
        designTextField(passwordTextField, text: "비밀번호", keyboardType: .default, secure: true)
        designTextField(nicknameTextField, text: "닉네임", keyboardType: .default, secure: false)
        designTextField(locationTextField, text: "위치", keyboardType: .default, secure: false)
        designTextField(codeTextField, text: "추천 코드 입력", keyboardType: .numberPad, secure: false)
                
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
    
    func designTextField(_ textField: UITextField, text: String, keyboardType: UIKeyboardType, secure: Bool) {
        textField.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .regular)])
        textField.textColor = .white
        textField.keyboardType = keyboardType
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        textField.isSecureTextEntry = secure
        textField.backgroundColor = .darkGray
    }

    @IBAction func registerButtonClicked(_ sender: UIButton) {
        view.endEditing(true)
        id = idTextField.text ?? ""
        password = passwordTextField.text ?? ""
        if Int(codeTextField.text!) != nil && id != "" && password.count >= 6 {
            let alert = UIAlertController(title: nil, message: "회원가입이 완료되었습니다.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .cancel)

            alert.addAction(ok)
            
            present(alert, animated: true, completion: nil)
            
        } else {
            let alert = UIAlertController(title: nil, message: "이메일, 비밀번호, 추천코드를 입력해주세요.(비밀번호 6자리이상)", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .cancel)

            alert.addAction(ok)
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func tapGestureClicked(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    

}
