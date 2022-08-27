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
    
    let tableView: UITableView = {
        let view = UITableView()
        
        return view
    }()
    
    let calendar: FSCalendar = {
        let view = FSCalendar()
        view.backgroundColor = .white
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .white
        [tableView, calendar].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(calendar.snp.bottom).offset(20)
            make.leading.equalTo(self).offset(20)
            make.trailing.equalTo(self).offset(-20)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        calendar.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(self).multipliedBy(0.3)
        }
    }
}
