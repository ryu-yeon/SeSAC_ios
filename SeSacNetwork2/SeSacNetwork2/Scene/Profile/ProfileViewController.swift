//
//  ProfileViewController.swift
//  SeSacNetwork2
//
//  Created by 유연탁 on 2022/11/03.
//

import UIKit

import Kingfisher
import RxCocoa
import RxSwift

class ProfileViewController: BaseViewController {
    
    private let mainView = ProfileView()
    let viewModel = ProfileViewModel()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.list
            .withUnretained(self)
            .bind { (vc, value) in
                let url = URL(string: value.user.photo)
                vc.mainView.photoImageView.kf.setImage(with: url)
                vc.mainView.usernameLabel.text = value.user.username
                vc.mainView.emailLabel.text = value.user.email
                vc.mainView.idLabel.text = value.user.id
            }
            .disposed(by: disposeBag)
        viewModel.fetch()
    }
}
