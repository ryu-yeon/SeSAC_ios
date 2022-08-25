//
//  ItemViewController.swift
//  ShoppingList
//
//  Created by 유연탁 on 2022/08/24.
//

import UIKit

import RealmSwift

class ItemViewController: BaseViewController {
    
    let mainView = ItemView()
    
    var item = ""
    var date = Date()
    
    var task: ShoppingList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func configure() {
        mainView.itemLable.text = task?.shoppingItem
        
        let format = DateFormatter()
        
        format.dateFormat = "yyyy.MM.dd hh:mm"
        
        mainView.dateLabel.text = format.string(from: task!.registerDate)
        
        mainView.addImageButton.addTarget(self, action: #selector(addImageButtonClicked), for: .touchUpInside)
        
    }
    
    @objc func addImageButtonClicked() {
        let vc = ImageSelectViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
