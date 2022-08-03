//
//  ReusableViewProtocol.swift
//  TMDB
//
//  Created by 유연탁 on 2022/08/04.
//

import UIKit

protocol ReusableViewProtocol {
    static var reusableidentifier: String { get }
}

extension ViewController: ReusableViewProtocol {
    static var reusableidentifier: String {
        return String(describing: self)
    }
}

extension CollectionViewCell: ReusableViewProtocol {
    static var reusableidentifier: String {
        return String(describing: self)
    }
}
