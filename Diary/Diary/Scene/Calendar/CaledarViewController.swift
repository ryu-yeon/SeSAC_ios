//
//  CaledarViewController.swift
//  Diary
//
//  Created by 유연탁 on 2022/08/27.
//

import UIKit

class CalendarViewController: BaseViewController {
    
    let mainView = CalendarView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configure() {
        
    }
    
}
