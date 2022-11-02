//
//  ProfileView.swift
//  SeSacNetwork2
//
//  Created by 유연탁 on 2022/11/03.
//

import UIKit

import SnapKit

class ProfileView: BaseView {
    
    let photoImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    let usernameLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 24)
        view.textColor = .label
        return view
    }()
    
    let emailLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 20)
        view.textColor = .label
        return view
    }()
    
    let idLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 20)
        view.textColor = .lightGray
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .systemBackground
        [photoImageView, usernameLabel, emailLabel, idLabel].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.centerX.equalTo(self)
            make.width.height.equalTo(100)
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(16)
            make.leading.equalTo(self).offset(20)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(8)
            make.leading.equalTo(self).offset(20)
        }
        
        idLabel.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(8)
            make.leading.equalTo(self).offset(20)
        }
    }
    
}
