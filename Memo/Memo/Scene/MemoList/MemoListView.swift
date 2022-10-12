//
//  MemoListView.swift
//  Memo
//
//  Created by 유연탁 on 2022/08/31.
//

import UIKit

import SnapKit

class MemoListView: BaseView {
    let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.backgroundColor = .backgroundColor
        return view
    }()
    
    let toolBar: UIToolbar = {
        let view = UIToolbar()
        view.barTintColor = .backgroundColor
        view.tintColor = .pointColor
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .backgroundColor
        [tableView, toolBar].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalTo(self)
            make.bottom.equalTo(toolBar.snp.top)
        }
        
        toolBar.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom)
            make.leading.trailing.equalTo(self)
            make.bottom.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.08)
        }
    }
}
