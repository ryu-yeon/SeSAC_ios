//
//  ViewController.swift
//  SeSacNetwork
//
//  Created by 유연탁 on 2022/07/28.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var webVIewButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem?.title = "Back"
        
        UserDefaultsHelper.standard.nickname = "고래밥"
        title = UserDefaultsHelper.standard.nickname
        
        UserDefaultsHelper.standard.age = 80
        print(UserDefaultsHelper.standard.age)
    }
    
    @IBAction func webViewButonClicked(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}
