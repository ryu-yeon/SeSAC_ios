//
//  ReusableViewProtocol.swift
//  Diary
//
//  Created by 유연탁 on 2022/08/24.
//

import Foundation
import UIKit


protocol ReusableViewProtocol {
    static var reusableIdentifier: String { get }
}

extension UIViewController: ReusableViewProtocol {
    static var reusableIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableViewProtocol {
    static var reusableIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReusableViewProtocol {
    static var reusableIdentifier: String {
        return String(describing: self)
    }
}

