//
//  LoginViewController.swift
//  SeSacNetwork2
//
//  Created by 유연탁 on 2022/11/03.
//

import UIKit

import RxCocoa
import RxSwift

class LoginViewController: BaseViewController {
    
    private let mainView = LoginView()
    private let viewModel = LoginViewModel()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.emailTextField.rx.text
            .orEmpty
            .withUnretained(self)
            .bind { (vc, value) in
                vc.viewModel.email = value
            }
            .disposed(by: disposeBag)
        
        mainView.passwordTextField.rx.text
            .orEmpty
            .withUnretained(self)
            .bind { (vc, value) in
                vc.viewModel.password = value
            }
            .disposed(by: disposeBag)
        
        mainView.loginButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                APIService().login(email: vc.viewModel.email, password: vc.viewModel.password) { check in
                    if check {
                        let nextVC = ProfileViewController()
                        vc.navigationController?.pushViewController(nextVC, animated: true)
                        
                    } else {
                        let alert = UIAlertController(title: "오류", message: "입력하신 정보가 일치하지 않습니다.", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "확인", style: .cancel)
                        alert.addAction(ok)
                        vc.present(alert, animated: true)
                    }
                }
            }
            .disposed(by: disposeBag)
        
        mainView.signupButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                let nextVC = SignUpViewController()
                vc.navigationController?.pushViewController(nextVC, animated: true)
            }
            .disposed(by: disposeBag)
    }
}
