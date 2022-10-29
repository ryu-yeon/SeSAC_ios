//
//  PopUpViewController.swift
//  Memo
//
//  Created by 유연탁 on 2022/08/31.
//

import UIKit

import RxCocoa
import RxSwift

class PopUpViewController: BaseViewController {
    
    private let mainView = PopUpView()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.okButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    override func viewWillLayoutSubviews() {
        mainView.viewContainer.layer.cornerRadius = mainView.viewContainer.bounds.width / 12
        mainView.okButton.layer.cornerRadius = mainView.okButton.bounds.width / 12
    }
}
