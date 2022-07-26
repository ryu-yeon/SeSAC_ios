//
//  UIViewController+Extension.swift
//  Tamagotchi
//
//  Created by 유연탁 on 2022/07/25.
//

import UIKit

extension UIViewController {
    func setNavigationBar(title: String) {
        navigationItem.title = title
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "mainColor") ?? UIColor.black]
        navigationController?.navigationBar.tintColor = UIColor(named: "mainColor")
        navigationController?.navigationBar.backgroundColor =  UIColor(named: "backgroundColor")
    }

}
