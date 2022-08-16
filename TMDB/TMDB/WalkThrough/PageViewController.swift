//
//  PageViewController.swift
//  TMDB
//
//  Created by 유연탁 on 2022/08/16.
//

import UIKit

class PageViewController: UIPageViewController {

    private var pageViewControllerList: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createPageViewController()
        configurePageViewController()
    }
    
    func createPageViewController() {
        let sb = UIStoryboard(name: "WalkThrough", bundle: nil)
        let vc1 = sb.instantiateViewController(withIdentifier: FirstViewController.reusableIdentifier) as! FirstViewController
        let vc2 = sb.instantiateViewController(withIdentifier: SecondViewController.reusableIdentifier) as! SecondViewController
        let vc3 = sb.instantiateViewController(withIdentifier: ThirdViewController.reusableIdentifier) as! ThirdViewController
        
        pageViewControllerList = [vc1, vc2, vc3]
    }
    
    func configurePageViewController() {
        delegate = self
        dataSource = self
        

        guard let first = pageViewControllerList.first else { return }
        setViewControllers([first], direction: .forward, animated: true)
    }
}

extension PageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = pageViewControllerList.firstIndex(of: viewController) else { return nil }
        
        let previoudIndex = viewControllerIndex - 1
        
        return previoudIndex < 0 ? nil : pageViewControllerList[previoudIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = pageViewControllerList.firstIndex(of: viewController) else { return nil }
        
        let previoudIndex = viewControllerIndex + 1
        
        return previoudIndex >= pageViewControllerList.count ? nil : pageViewControllerList[previoudIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageViewControllerList.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let first = viewControllers?.first, let index = pageViewControllerList.firstIndex(of: first) else { return 0 }
        
        return index
    }
}
