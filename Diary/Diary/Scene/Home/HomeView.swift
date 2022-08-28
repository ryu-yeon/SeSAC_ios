//
//  HomeView.swift
//  Diary
//
//  Created by 유연탁 on 2022/08/24.
//

import UIKit

import SnapKit
import FSCalendar

class HomeView: BaseView {
    
    let userSearchBar: UISearchBar = {
        let view = UISearchBar()
        return view
    }()
    
    let tableView: UITableView = {
        let view = UITableView()
        
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .white
        [userSearchBar, tableView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        userSearchBar.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(30)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(userSearchBar.snp.bottom).offset(8)
            make.leading.equalTo(self).offset(20)
            make.trailing.equalTo(self).offset(-20)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
