//
//  BaseView.swift
//  SeSacNetwork2
//
//  Created by 유연탁 on 2022/11/03.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        setConstraints()
        print("INIT🟢🟢🟢")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("DEINIT🔴🔴🔴")
    }
    
    func configureUI() {
        
    }
    
    func setConstraints() {
        
    }
}
