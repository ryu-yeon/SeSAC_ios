//
//  ReusableViewProtocol.swift
//  Tamagotchi
//
//  Created by 유연탁 on 2022/08/01.
//

import UIKit

protocol ReusableViewProtocol {
    static var reusableIenditifier: String { get }
}

extension UIViewController: ReusableViewProtocol {
    static var reusableIenditifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableViewProtocol {
    static var reusableIenditifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReusableViewProtocol {
    static var reusableIenditifier: String {
        return String(describing: self)
    }
}
