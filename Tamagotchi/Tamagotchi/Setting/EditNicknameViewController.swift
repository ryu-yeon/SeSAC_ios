//
//  EditNicknameViewController.swift
//  Tamagotchi
//
//  Created by 유연탁 on 2022/07/22.
//

import UIKit
import Toast

class EditNicknameViewController: UIViewController {
    
    var nickname: String?
    
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var lineView: UIView!
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        nickname = UserDefaults.standard.string(forKey: "nickname")
        
        setNavigationBar(title: "\(nickname ?? "대장님") 이름 정하기")
        setNavigationBarItem()
        setViewDesign()
    }
    
    //MARK: - 저장버튼 클릭 설정
    @objc func saveNickname() {
        nickname = nicknameTextField.text
        
        if (2...6).contains(nickname?.count ?? 0) {
            UserDefaults.standard.set(nickname, forKey: "nickname")
            navigationController?.popViewController(animated: true)
        } else {
            self.view.makeToast("2글자 이상 6글자 이하까지 가능합니다.", duration: 1, position: .center)
        }
    }
    
    //MARK: - NavigationBarItem 설정
    func setNavigationBarItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveNickname))
    }
    
    //MARK: - UI 설정
    func setViewDesign() {
        view.backgroundColor = .myBackgroundColor
        
        nicknameTextField.text = nickname
        nicknameTextField.borderStyle = .none
        nicknameTextField.textColor = .myMainColor
        
        lineView.backgroundColor = .myMainColor
    }
}
