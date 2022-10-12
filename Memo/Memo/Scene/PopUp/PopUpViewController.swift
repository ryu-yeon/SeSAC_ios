//
//  PopUpViewController.swift
//  Memo
//
//  Created by 유연탁 on 2022/08/31.
//

import UIKit

class PopUpViewController: BaseViewController {
    
    private let mainView = PopUpView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillLayoutSubviews() {
        mainView.viewContainer.layer.cornerRadius = mainView.viewContainer.bounds.width / 12
        mainView.okButton.layer.cornerRadius = mainView.okButton.bounds.width / 12
    }
    
    override func configure() {
        mainView.okButton.addTarget(self, action: #selector(okButtonClicked), for: .touchUpInside)
    }
    
    @objc func okButtonClicked() {
        dismiss(animated: true)
    }
}
