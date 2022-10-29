//
//  CreateFolderViewController.swift
//  Memo
//
//  Created by 유연탁 on 2022/10/20.
//

import UIKit

import RxCocoa
import RxSwift

class CreateFolderViewController: BaseViewController {
    
    private let mainView = CreateFoderView()
    private let folderRepository = FolderRepository()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigtaionBar()
        mainView.userTextField.becomeFirstResponder()
    }
    
    override func setNavigtaionBar() {
        navigationItem.title = "새로운 폴더"
        
        let cancelButton = UIBarButtonItem(title: "취소")
        let okButton = UIBarButtonItem(title: "완료")
        
        cancelButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        
        okButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.folderRepository.saveFolder(title: vc.mainView.userTextField.text ?? "새로운 폴더")
                vc.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = okButton
    }
}

