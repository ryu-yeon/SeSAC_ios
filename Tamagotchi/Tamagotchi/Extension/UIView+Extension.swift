//
//  UIView+Extension.swift
//  Tamagotchi
//
//  Created by 유연탁 on 2022/07/25.
//

import UIKit

extension UIView {
    func setBorderRound() {
        layer.borderWidth = 1.5
        layer.borderColor = UIColor(named: "mainColor")?.cgColor
        layer.cornerRadius = 10
        clipsToBounds = true
    }
}


