//
//  SettingViewController.swift
//  ShoppingList
//
//  Created by 유연탁 on 2022/08/25.
//

import UIKit

class SettingViewController: BaseViewController {
    
    let mainView = SettingView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configure() {
        
    }
}
