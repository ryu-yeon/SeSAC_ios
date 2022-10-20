//
//  CreateFolderViewController.swift
//  Memo
//
//  Created by 유연탁 on 2022/10/20.
//

import UIKit

class CreateFolderViewController: BaseViewController {
    
    private let mainView = CreateFoderView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationItem.title = "새로운 폴더"
        navigationController?.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancleButtonClicked))
        navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(okButtonClicked))
    }
    
    @objc func cancleButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func okButtonClicked() {
        
    }
}

