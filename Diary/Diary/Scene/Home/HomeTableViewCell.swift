//
//  HomeTableViewCell.swift
//  Diary
//
//  Created by 유연탁 on 2022/08/24.
//

import UIKit

import SnapKit

class HomeTableViewCell: BaseTableViewCell {
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 15)
        return view
    }()
    
    let diaryImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .gray
        return view
    }()
    
    let dateLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 13)
        return view
    }()
    
    let contentLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 13)
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .white
        [diaryImageView, titleLabel, dateLabel, contentLabel].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(diaryImageView.snp.trailing).offset(20)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(20)
        }
        
        diaryImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(self.safeAreaLayoutGuide).offset(16)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-16)
            make.width.equalTo(self).multipliedBy(0.25)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.equalTo(diaryImageView.snp.trailing).offset(20)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(20)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom)
            make.leading.equalTo(diaryImageView.snp.trailing).offset(20)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-20)
            make.bottom.equalTo(self).offset(-20)
        }
    }
}
