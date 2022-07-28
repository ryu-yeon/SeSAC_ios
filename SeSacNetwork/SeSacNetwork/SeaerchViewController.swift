//
//  ViewController.swift
//  SeSacNetwork
//
//  Created by 유연탁 on 2022/07/27.
//

import UIKit

/*
 Swift Protocol
 - Delegate
 - Datasource
 
 1. 왼팔/오른팔
 2. 테이블뷰 아웃렛 연결
 3. 1 + 2
 */


class SearchViewController: UIViewController, ViewPresentableProtocol, UITableViewDelegate, UITableViewDataSource {
    
    var navigationTitleString: String = ""
    
    var backgroundColor: UIColor = .white
    
    static var identifier: String = "SearchViewController"
    
  
    @IBOutlet var searchTableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        //연결고리 작업: 테이블뷰가 해야 할 역할 > 뷰 컨드롤러에게 요청
        searchTableView.delegate = self
        searchTableView.dataSource = self
        //테이블뷰가 사용할 테이블뷰 셀(XIB) 등록
        //XIB: xml interface builder <= NIBB
        searchTableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: ListTableViewCell.identifier)
    }
    
    func configureView() {
        searchTableView.backgroundColor = .clear
        searchTableView.separatorColor = .clear
        searchTableView.rowHeight = 60
    }
    
    func configureLabel() {
    
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        
        cell.backgroundColor = .clear
        cell.titleLabel.font = .boldSystemFont(ofSize: 22)
        cell.titleLabel.text = "ㅎㅇㅎㅇ"
        
        return cell
    }

}

