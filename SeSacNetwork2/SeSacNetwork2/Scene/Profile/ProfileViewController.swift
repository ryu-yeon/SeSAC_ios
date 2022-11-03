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

final class ProfileViewController: BaseViewController {
    
    private let mainView = ProfileView()
    let viewModel = ProfileViewModel()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.profile
            .withUnretained(self)
            .subscribe { (vc, value) in
                let url = URL(string: value.user.photo)
                vc.mainView.photoImageView.kf.setImage(with: url)
                vc.mainView.usernameLabel.text = value.user.username
                vc.mainView.emailLabel.text = value.user.email
                vc.mainView.idLabel.text = value.user.id
            } onError: { error in
                print(error.localizedDescription)
            }
            .disposed(by: disposeBag)

        
        //subscribe, bind, drive
        
        //driver vs signal
                       
        viewModel.fetchProfile()
        checkCOW()
    }
    
    func checkCOW() {
        var test = "jack"
        address(&test) // in out 매개변수
        
        var test2 = test
        address(&test2)
        
        test2 = "sesac"
        address(&test)
        address(&test2)
        
        print("++++++++")
        
        var array = Array(repeating: "A", count: 100)
        address(&array)
        
        var newArray = array
        address(newArray)
        
        newArray[0] = "B"
        
        address(&array)
        address(&newArray)
    }
    
    func address(_ value: UnsafeRawPointer) {
        let address = String(format: "%p", Int(bitPattern: value))
        print(address)
    }
    
}
