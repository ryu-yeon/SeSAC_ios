//
//  ViewController.swift
//  CodeBaseUI
//
//  Created by 유연탁 on 2022/08/17.
//

import UIKit

import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let vc = SecondViewController()
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
}

