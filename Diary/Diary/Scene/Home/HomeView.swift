//
//  HomeView.swift
//  Diary
//
//  Created by 유연탁 on 2022/08/24.
//

import UIKit

import SnapKit

class HomeView: BaseView {
    
    let tableView: UITableView = {
        let view = UITableView()
        
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .white
        self.addSubview(tableView)
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.equalTo(self).offset(20)
            make.trailing.equalTo(self).offset(-20)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
