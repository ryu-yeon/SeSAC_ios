//
//  BlackRadiusTextField.swift
//  SeSacWeek7Diary
//
//  Created by 유연탁 on 2022/08/19.
//

import UIKit

class BlackRadiiusTextField : UITextField {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = .clear
        textAlignment = .center
        borderStyle = .none
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
    }
}
