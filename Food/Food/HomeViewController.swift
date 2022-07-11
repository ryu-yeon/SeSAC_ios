//
//  SecondViewController.swift
//  Food
//
//  Created by 유연탁 on 2022/07/05.
//

import UIKit

class HomeController: UIViewController {
   
    
    //뷰컨트롤러 생명주기 종류 중 하나
    //사용자에게 화면이 보이기 직전에 실행되는 코드
    // option command < >
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = .clear
        
    }
    
}
