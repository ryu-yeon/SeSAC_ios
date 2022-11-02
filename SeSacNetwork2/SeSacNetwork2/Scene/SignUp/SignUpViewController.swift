//
//  SignUpViewController.swift
//  SeSacNetwork2
//
//  Created by 유연탁 on 2022/11/03.
//

import UIKit

import RxCocoa
import RxSwift

class SignUpViewController: BaseViewController {
    
    private let mainView = SignUpView()
    private let viewModel = SignUpViewModel()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        
        mainView.usernameTextField.rx.text
            .orEmpty
            .withUnretained(self)
            .bind { (vc, value) in
                vc.viewModel.username = value
                vc.mainView.signupButton.isEnabled = vc.viewModel.signButtonEnable()
            }
            .disposed(by: disposeBag)
        
        mainView.emailTextField.rx.text
            .orEmpty
            .withUnretained(self)
            .bind { (vc, value) in
                vc.viewModel.email = value
                vc.mainView.signupButton.isEnabled = vc.viewModel.signButtonEnable()
            }
            .disposed(by: disposeBag)
        
        mainView.passwordTextField.rx.text
            .orEmpty
            .withUnretained(self)
            .bind { (vc, value) in
                vc.viewModel.password = value
                vc.mainView.signupButton.isEnabled = vc.viewModel.signButtonEnable()
            }
            .disposed(by: disposeBag)
        
        mainView.signupButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                APIService().signup(username: vc.viewModel.username, email: vc.viewModel.email, password: vc.viewModel.password)
                vc.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }
}
