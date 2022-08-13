//
//  ReusableViewProtocol.swift
//  CardWeather
//
//  Created by 유연탁 on 2022/08/13.
//

import UIKit

protocol ReusableViewProtocol {
    static var reusableidentifier: String { get }
}

extension UIViewController: ReusableViewProtocol {
    static var reusableidentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableViewProtocol {
    static var reusableidentifier: String {
        return String(describing: self)
    }
}
