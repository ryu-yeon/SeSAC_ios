//
//  SettingTableViewCell.swift
//  Diary
//
//  Created by 유연탁 on 2022/08/25.
//

import UIKit

class SettingTableViewCell: BaseTableViewCell {
    
    let dataLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 20)
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .lightGray
        self.addSubview(dataLabel)
    }
    
    override func setConstraints() {
        dataLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(self).multipliedBy(0.6)
        }
    }
}

