//
//  Codesnap2ViewController.swift
//  SeSacWeek7Diary
//
//  Created by 유연탁 on 2022/08/17.
//

import UIKit

class Codesnap2ViewController: UIViewController {

    let blackView: UIView = {
            let view = UIView()
            view.backgroundColor = .black
            return view
        }()

        let redView: UIView = {
            let view = UIView()
            view.backgroundColor = .red
            return view
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        [redView, blackView].forEach {
            view.addSubview($0)
        }
        
        redView.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(200)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalTo(view)
        }
        
        blackView.snp.makeConstraints { make in
            make.edges.equalTo(redView).inset(50)
        }
    }
}
