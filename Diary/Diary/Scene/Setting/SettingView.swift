//
//  SettingView.swift
//  Diary
//
//  Created by 유연탁 on 2022/08/25.
//

import UIKit

import SnapKit

class SettingView: BaseView {
    
    let backupButton: UIButton = {
       let view = UIButton()
        view.setTitle("백업", for: .normal)
        view.backgroundColor = .lightGray
        return view
    }()
    
    let loadButton: UIButton = {
        let view = UIButton()
        view.setTitle("복구", for: .normal)
        view.backgroundColor = .lightGray
        return view
    }()
    
    let tableView: UITableView = {
        let view = UITableView()
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .white
        [backupButton, loadButton, tableView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        backupButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(20)
            make.width.height.equalTo(80)
        }
        
        loadButton.snp.makeConstraints { make in
            make.top.equalTo(backupButton.snp.bottom).offset(40)
            make.leading.equalTo(20)
            make.width.height.equalTo(80)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(loadButton.snp.bottom).offset(40)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}

