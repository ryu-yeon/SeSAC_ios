//
//  FirstViewController.swift
//  Food
//
//  Created by 유연탁 on 2022/07/08.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if #available(iOS 15.0, *) {
            self.navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = .systemMint
        } else {
            // Fallback on earlier versions
        }
        
        self.navigationController?.navigationBar.scrollEdgeAppearance?.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = .white
        self.navigationController?.navigationBar.scrollEdgeAppearance?.titleTextAttributes = [.foregroundColor: UIColor.black]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        topView.layer.cornerRadius = 8
    }


}
