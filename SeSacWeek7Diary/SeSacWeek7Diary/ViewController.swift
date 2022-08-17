//
//  ViewController.swift
//  SeSacWeek7Diary
//
//  Created by 유연탁 on 2022/08/16.
//

import UIKit
import SeSacUIFramwork

class ViewController: UIViewController {

    var name = "고래밥"
    var age = 22
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let vc = Codesnap2ViewController()
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
        
        
        
        
        testOpen()

        
        OpenWebView.presentWebViewController(self, url: "https://www.naver.com", transitionStyle: .present)
        
    }
    
    @IBAction func alertButtonClicked(_ sender: UIButton) {
        showSesacAlert(title: "얼럿 타이틀", message: "얼럿 메시지", buttonTitle: "확인") { _ in
            self.view.backgroundColor = .green
        }
    }
    
    @IBAction func activityButtonClicked(_ sender: UIButton) {
        let image = UIImage(systemName: "star.fill")!
        let url = "https://www.apple.com"
        let text = "WWDC22 What's NEW!!!"
        sesacShowActivityViewController(shareImage: image, shareURL: url, shareText: text)
    }
    
}

