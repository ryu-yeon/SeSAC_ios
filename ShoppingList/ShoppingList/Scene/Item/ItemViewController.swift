//
//  ItemViewController.swift
//  ShoppingList
//
//  Created by 유연탁 on 2022/08/24.
//

import UIKit

class ItemViewController: BaseViewController {
    
    let itemView = ItemView()
    
    var item = ""
    var date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func loadView() {
        self.view = itemView
    }
    
    override func configure() {
        itemView.itemLable.text = item
        
        let format = DateFormatter()
        
        format.dateFormat = "yyyy.MM.dd hh:mm"
        
        itemView.dateLabel.text = format.string(from: date)
        
    }
}
