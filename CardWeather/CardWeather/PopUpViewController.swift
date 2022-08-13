//
//  PopUpViewController.swift
//  CardWeather
//
//  Created by 유연탁 on 2022/08/13.
//

import UIKit

class PopUpViewController: UIViewController {

    @IBOutlet weak var settingView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settingView.layer.cornerRadius = 40
    }
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
}
