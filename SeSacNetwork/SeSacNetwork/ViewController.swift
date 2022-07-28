//
//  ViewController.swift
//  SeSacNetwork
//
//  Created by 유연탁 on 2022/07/28.
//

import UIKit

class ViewController: UIViewController, ViewPresentableProtocol {
    
    static let identifier: String = "ViewController"
    
    var navigationTitleString: String = "대장님의 다마고치"
    
    let backgroundColor: UIColor = .blue
    
    func configureView() {
        
        navigationTitleString = "고래밥님의 다마고치"
//        backgroundColor = .red
        
        title = navigationTitleString
        view.backgroundColor = backgroundColor
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    

}
