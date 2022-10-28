//
//  FolderListTableViewCell.swift
//  Memo
//
//  Created by 유연탁 on 2022/10/27.
//

import UIKit

import SnapKit

class FolderListTableViewCell: BaseTableViewCell {
    
    let folderImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "folder")
        view.tintColor = .pointColor
        return view
    }()
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "메모"
        view.textColor = .label
        view.font = .systemFont(ofSize: 20)
        return view
    }()
    
    let countLabel: UILabel = {
        let view = UILabel()
        view.text = "3"
        view.textColor = .lightGray
        view.textAlignment = .right
        view.font = .boldSystemFont(ofSize: 16)
        return view
    }()
    
    let arrowImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.right")
        view.tintColor = .lightGray
        return view
    }()
    
    override func configureUI() {
        contentView.backgroundColor = .viewBackgroundColor
        [folderImageView, titleLabel, countLabel, arrowImageView].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        folderImageView.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.leading.equalTo(self).offset(16)
            make.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.leading.equalTo(folderImageView.snp.trailing).offset(16)
            make.trailing.equalTo(countLabel.snp.leading).offset(-16)
        }
        
        countLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.trailing.equalTo(arrowImageView.snp.leading).offset(-16)
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.trailing.equalTo(self).offset(-16)
            make.height.equalTo(16)
            make.width.equalTo(12)
        }
    }
}
