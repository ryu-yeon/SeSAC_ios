//
//  CALayer+Extension.swift
//  Tamagotchi
//
//  Created by 유연탁 on 2022/07/25.
//
import UIKit

extension CALayer {
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
            if edge == UIRectEdge.top {
                border.frame = CGRect.init(x: 0, y: width, width: frame.width, height: width)
            } else if edge == UIRectEdge.bottom {
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
            }
            border.backgroundColor = color.cgColor
            self.addSublayer(border)
        }
    }
    
    func addTopBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
            if edge == UIRectEdge.top {
                border.frame = CGRect.init(x: 0, y: -width, width: frame.width, height: width)
            } 
            border.backgroundColor = color.cgColor
            self.addSublayer(border)
        }
    }
}


