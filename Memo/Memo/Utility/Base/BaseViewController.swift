//
//  BaseViewController.swift
//  Memo
//
//  Created by 유연탁 on 2022/08/31.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setNavigtaionTitle(title: String) {
        navigationItem.title = title
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setSearchController() {
        let searchController = UISearchController()
//        UISearchController(searchResultsController: nil)
        
        navigationController?.navigationBar.backgroundColor = .viewBackgroundColor
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationItem.largeTitleDisplayMode = .always
//        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "검색"
        searchController.searchBar.setValue("취소", forKey: "cancelButtonText")
        navigationItem.searchController = searchController
    }
    
    func setNavigtaionBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .viewBackgroundColor
        appearance.titleTextAttributes = [.foregroundColor: UIColor.textColor]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.textColor]
        
        navigationController?.navigationBar.tintColor = .pointColor
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}
