//
//  CreateFolderViewController.swift
//  Memo
//
//  Created by 유연탁 on 2022/10/20.
//

import UIKit

class CreateFolderViewController: BaseViewController {
    
    private let mainView = CreateFoderView()
    private let folderRepository = FolderRepository()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "새로운 폴더"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancleButtonClicked))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(okButtonClicked))
        setNavigtaionBar()
        mainView.userTextField.becomeFirstResponder()
    }
    
    @objc func cancleButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func okButtonClicked() {
        folderRepository.saveFolder(title: mainView.userTextField.text ?? "새로운 폴더")
        dismiss(animated: true)
    }
}

