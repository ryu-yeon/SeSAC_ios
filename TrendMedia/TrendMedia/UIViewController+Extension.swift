//
//  UIViewController+Extension.swift
//  TrendMedia
//
//  Created by 유연탁 on 2022/07/19.
//

import UIKit

extension UIViewController {
    
    
    func setBackgroundColor() {
        
        view.backgroundColor = .orange
    }
    
    func showAlert() {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .destructive)
        let cancle = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(ok)
        alert.addAction(cancle)
        
        present(alert, animated: true)
        
    }
}
