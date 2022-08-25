//
//  ReusableViewProtocol.swift
//  ShoppingList
//
//  Created by 유연탁 on 2022/08/22.
//

import UIKit

protocol ReuableViewProtocol {
    static var reuableIdentifier: String { get }
}

extension UIViewController: ReuableViewProtocol {
    static var reuableIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReuableViewProtocol {
    static var reuableIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReuableViewProtocol {
    static var reuableIdentifier: String {
        return String(describing: self)
    }
}

