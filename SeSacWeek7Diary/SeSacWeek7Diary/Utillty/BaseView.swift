//
//  BaseView.swift
//  SeSacWeek7Diary
//
//  Created by 유연탁 on 2022/08/19.
//

import UIKit

class BaseView: UIView {
    
    //코드 베이스
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        setConstaints()
    }
    
    //xib storyboard, protocol
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented") //런타임 오류
    }
    
    func configureUI() {
        
        
    }
    
    func setConstaints() {
        
    }
    
    
}


//required initializer
protocol example {
    init(name: String)
}

class Mobile: example {
    let name: String
    
    required init(name: String) {
        self.name = name
    }
}

class Apple: Mobile {
    let wwdc: String
    
    init(wwdc: String) {
        self.wwdc = wwdc
        
        super.init(name: "모바일")
    }
    
    required init(name: String) {
        fatalError("init(name:) has not been implemented")
    }
    
}

let a = Apple(wwdc: "애플")
