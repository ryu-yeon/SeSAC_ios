//
//  UILabel+Extension.swift
//  Tamagotchi
//
//  Created by 유연탁 on 2022/07/25.
//

import UIKit

extension UILabel {
    func setText(textFont: UIFont) {
        backgroundColor = UIColor(named: "backgroundColor")
        textColor = UIColor(named: "mainColor")
        textAlignment = .center
        font = textFont
    }
}
