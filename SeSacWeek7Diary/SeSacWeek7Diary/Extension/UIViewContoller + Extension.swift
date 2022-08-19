//
//  UIViewContoller + Extensgion.swift
//  SeSacWeek7Diary
//
//  Created by 유연탁 on 2022/08/18.
//

import UIKit

extension UIViewController {
    func transitionViewController<T: UIViewController>(storyboard: String, ViewController vc: T) {
        let sb = UIStoryboard(name: storyboard, bundle: nil)
        guard let controller = sb.instantiateViewController(identifier: String(describing: vc)) as? T else { return }
        
        self.present(controller, animated: true)
    }
}
