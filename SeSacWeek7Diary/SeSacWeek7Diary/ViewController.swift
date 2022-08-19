//
//  ViewController.swift
//  SeSacWeek7Diary
//
//  Created by 유연탁 on 2022/08/16.
//

import UIKit
import SeSacUIFramwork
import SnapKit

class ViewController: UIViewController {


    let nameButton: UIButton = {
       let view = UIButton()
        view.setTitle("닉네임", for: .normal)
        view.backgroundColor = .black
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        
        NotificationCenter.default.addObserver(self, selector: #selector(saveButtonNotificationObserver(notification:)), name: NSNotification.Name("saveButtonNotification"), object: nil)
    }
    
    @objc func saveButtonNotificationObserver(notification: NSNotification) {
        if let name = notification.userInfo?["name"] as? String {
            print(name)
            self.nameButton.setTitle(name, for: .normal)
        }
    }
    
    func configure() {
        view.addSubview(nameButton)
        
        nameButton.snp.makeConstraints { make in
            make.width.height.equalTo(200)
            make.center.equalTo(view)
        }
        nameButton.addTarget(self, action: #selector(nameButtonClicked), for: .touchUpInside)
    }
    
    
    @objc func nameButtonClicked() {
        
        NotificationCenter.default.post(name: NSNotification.Name("TEST"), object: nil, userInfo: ["name": Int.random(in: 1...100), "value": 123456])
        
        
        let vc = ProfileViewController()
        
        vc.saveButtonActionHandeler = { name in
            self.nameButton.setTitle(name, for: .normal)
        }
        
        present(vc, animated: true)
    }
}
