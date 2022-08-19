//
//  ProfileViewController.swift
//  SeSacWeek7Diary
//
//  Created by 유연탁 on 2022/08/18.
//

import UIKit

class ProfileViewController: UIViewController {

    let saveButton: UIButton = {
        let view = UIButton()
        view.setTitle("저장", for: .normal)
        view.backgroundColor = .black
        return view
    }()
    
    let nameTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "이름을 입력하세요."
        view.backgroundColor = .brown
        view.textColor = .white
        return view
    }()
    
    var saveButtonActionHandeler: (() -> ())? //함수 자체
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .yellow
        configure()
        
        
    }


    func configure() {
        [saveButton, nameTextField].forEach {
            view.addSubview($0)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view).inset(50)
            make.top.equalTo(50)
            make.height.equalTo(50)
        }
        
        saveButton.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.center.equalTo(view)
        }
        
        saveButton.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
    }
    
    
    @objc func saveButtonClicked() {
        
        // 값 전달 기능 실행 => 클로저 구문 활용
        saveButtonActionHandeler?()
        // 화면 Dismiss
        dismiss(animated: true)
    }
}
