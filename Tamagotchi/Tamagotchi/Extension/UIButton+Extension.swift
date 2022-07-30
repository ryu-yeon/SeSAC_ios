//
//  UIButton+Extension.swift
//  Tamagotchi
//
//  Created by 유연탁 on 2022/07/25.
//

import UIKit

extension UIButton {
    func setButton(title: String, image: UIImage, textFont: UIFont) {
        setTitle(title, for: .normal)
        setImage(image, for: .normal)
        titleLabel?.font = textFont
        backgroundColor = .myBackgroundColor
        tintColor = .myMainColor
    }
}
