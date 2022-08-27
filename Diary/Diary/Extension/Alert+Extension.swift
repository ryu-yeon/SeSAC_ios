//
//  Alert+Extension.swift
//  Diary
//
//  Created by 유연탁 on 2022/08/25.
//

import UIKit

extension UIViewController {
    
    func showAlertMessage(text: String) {
        let alert = UIAlertController(title: "\(text)", message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(ok)
        present(alert, animated: true)
    }
}
