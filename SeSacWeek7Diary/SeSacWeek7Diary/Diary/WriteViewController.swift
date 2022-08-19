//
//  WriteViewController.swift
//  SeSacWeek7Diary
//
//  Created by 유연탁 on 2022/08/19.
//

import UIKit

import SnapKit

class WriteViewController: BaseViewController {
    
    let mainView = WriteView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    
    }
    
    //viewDidLoad보다 먼저 호출
    override func loadView() { //super.loadView X
        self.view = mainView
    }
    
    override func configure() {
        mainView.titleTextField.addTarget(self, action: #selector(titleTextFieldClicked(_:)), for: .editingDidEndOnExit)
    }
    
    @objc func titleTextFieldClicked(_ textField: UITextField) {
        guard let text = textField.text, text.count > 0 else {
            showAlertMessage(title: "제목을 입력해주세요", button: "확인")
            return
        }
    }

}
