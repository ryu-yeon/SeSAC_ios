//
//  SearchViewController.swift
//  Book
//
//  Created by 유연탁 on 2022/07/21.
//

import UIKit

class SearchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.title = "검색"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        navigationItem.leftBarButtonItem?.tintColor = .red
    }
    
    @objc func closeButtonClicked() {
        dismiss(animated: true)
    }
    
}
