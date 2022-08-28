//
//  CalendarView.swift
//  Diary
//
//  Created by 유연탁 on 2022/08/27.
//

import UIKit

import FSCalendar
import SnapKit

class CalendarView: BaseView {
    
    let calendar: FSCalendar = {
        let view = FSCalendar()
        view.backgroundColor = .white
        return view
    }()
    
//    let tableView: UITableView = {
//        let view = UITableView()
//        return view
//    }()
    
    override func configureUI() {
        self.backgroundColor = .white
        [calendar].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        calendar.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(self).multipliedBy(0.3)
        }
    }
}
