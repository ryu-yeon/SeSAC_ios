//
//  SeSacButton.swift
//  SeSacWeek6
//
//  Created by 유연탁 on 2022/08/09.
//

import UIKit

/*
 Swift Atrribute(속성)
 @IBInspectable, @IBDesignabel, @objc, @escaping, @abailable, etc
 */

//인터페이스 빌더 컴파일 시점 실시간으로 객체 속성을 확인 할 수 있음
@IBDesignable class SeSacButton: UIButton {

    //인터페이스 빌더 인스펙터 영역 Show
    @IBInspectable var conrnerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColr: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
}
