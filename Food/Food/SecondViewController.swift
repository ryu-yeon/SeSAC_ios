//
//  SecondViewController.swift
//  Food
//
//  Created by 유연탁 on 2022/07/05.
//

import UIKit

class SecondViewController: UIViewController {

    //아울렛 변수
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    //뷰컨트롤러 생명주기 종류 중 하나
    //사용자에게 화면이 보이기 직전에 실행되는 코드
    // option command < >
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodImageView.image = UIImage(named: "cake")
        foodImageView.layer.cornerRadius = 100
        foodImageView.layer.borderWidth = 5
        foodImageView.layer.borderColor = UIColor.blue.cgColor
        
        titleLabel.text = "케이크"
        titleLabel.backgroundColor = .yellow
        titleLabel.textColor = .red
        titleLabel.font = .boldSystemFont(ofSize: 30)

    }
    
    @IBAction func resultButtonClicked(_ sender: UIButton) {
        
    }
}
