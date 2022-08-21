//
//  DiaryViewController.swift
//  Diary
//
//  Created by 유연탁 on 2022/08/21.
//

import UIKit

import Kingfisher

class DiaryViewController: BaseViewController {
    
    let mainView = DiaryView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        self.mainView.addImageButton.layer.cornerRadius = self.mainView.addImageButton.bounds.height / 2
        
       
    
    }
    
    override func loadView() {
        self.view = mainView
        
    }
    
    override func configure() {
        mainView.addImageButton.addTarget(self, action: #selector(addImageButtonClicked), for: .touchUpInside)
    }
    
    @objc func addImageButtonClicked() {
        let vc = ImageSelectViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
