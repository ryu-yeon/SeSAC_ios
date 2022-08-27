//
//  TabBarController.swift
//  Diary
//
//  Created by 유연탁 on 2022/08/27.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBarController()
        setupTabBarAppearence()
    }
    
    func configureTabBarController() {
        let firstVC = HomeViewController()
        firstVC.tabBarItem.title = "Home"
        firstVC.tabBarItem.image = UIImage(systemName: "house")
        firstVC.tabBarItem.selectedImage = UIImage(systemName: "house.fill")

        
        let secondVC = CalendarViewController()
        secondVC.tabBarItem.title = "Calendar"
        secondVC.tabBarItem.image = UIImage(systemName: "calendar")
//        secondVC.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        
        let thirdVC = SettingViewController()
        thirdVC.tabBarItem.title = "Setting"
        thirdVC.tabBarItem.image = UIImage(systemName: "gearshape")
        thirdVC.tabBarItem.selectedImage = UIImage(systemName: "gearshape.fill")
        
        setViewControllers([firstVC, secondVC, thirdVC], animated: true)
    }
    
    func setupTabBarAppearence() {
        
    }
}
