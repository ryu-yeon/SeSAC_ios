//
//  FirstViewController.swift
//  CodeBaseUI
//
//  Created by 유연탁 on 2022/08/17.
//

import UIKit

class FirstViewController: UIViewController {

    let xButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "xmark"), for: .normal)
        view.tintColor = .white
        return view
    }()
    
    let giftButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "gift.circle"), for: .normal)
        view.tintColor = .white
        return view
    }()
    
    let qrButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "circle.grid.3x3.circle"), for: .normal)
        view.tintColor = .white
        return view
    }()
    
    let settingButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "gearshape.circle"), for: .normal)
        view.tintColor = .white
        return view
    }()
    
    let profileImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "person.fill")
        view.tintColor = .lightGray
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 40
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    
    let nicknameLabel: UILabel =  {
        let view = UILabel()
        view.text = "Nick Name"
        view.textAlignment = .center
        view.textColor = .white
        view.font = .boldSystemFont(ofSize: 20)
        return view
    }()
    
    let chatButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "message.fill"), for: .normal)
        view.tintColor = .white
        return view
    }()
    
    let editButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "pencil"), for: .normal)
        view.tintColor = .white
        return view
    }()
    
    let kakaoStoryButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "quote.closing"), for: .normal)
        view.tintColor = .white
        return view
    }()
    
    let chatLabel: UILabel = {
        let view = UILabel()
        view.text = "나와의 채팅"
        view.textColor = .white
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 15)
        return view
    }()
    
    let editLabel: UILabel = {
        let view = UILabel()
        view.text = "프로필 편집"
        view.textColor = .white
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 15)
        return view
    }()
    
    let kakaoStoryLabel: UILabel = {
        let view = UILabel()
        view.text = "카카오스토리"
        view.textColor = .white
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 15)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray

        configureUI()
    }
    
    func configureUI() {
        [xButton, giftButton, qrButton, settingButton, profileImageView, nicknameLabel, chatButton, editButton, kakaoStoryButton, chatLabel, editLabel, kakaoStoryLabel].forEach {
            view.addSubview($0)
        }
        
        xButton.snp.makeConstraints { make in
            make.topMargin.equalTo(20)
            make.leading.equalTo(20)
            make.width.equalTo(36)
            make.height.equalTo(36)
        }
        
        giftButton.snp.makeConstraints { make in
            make.topMargin.equalTo(28)
            make.trailingMargin.equalTo(qrButton.snp.leading).offset(-16)
            make.width.equalTo(xButton.snp.width)
            make.width.equalTo(xButton.snp.height)
        }
        
        qrButton.snp.makeConstraints { make in
            make.topMargin.equalTo(28)
            make.trailingMargin.equalTo(settingButton.snp.leading).offset(-16)
            make.width.equalTo(xButton.snp.width)
            make.width.equalTo(xButton.snp.height)
        }
        
        settingButton.snp.makeConstraints { make in
            make.topMargin.equalTo(28)
            make.trailing.equalTo(-20)
            make.width.equalTo(xButton.snp.width)
            make.width.equalTo(xButton.snp.height)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).multipliedBy(1.3)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(16)
            make.width.equalTo(view).multipliedBy(0.4)
            make.height.equalTo(20)
            make.centerX.equalTo(view)
        }
        
        chatButton.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(40)
            make.width.equalTo(80)
            make.height.equalTo(40)
            make.trailing.equalTo(editButton.snp.leading).offset(-40)
        }
        
        editButton.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(40)
            make.width.equalTo(80)
            make.height.equalTo(40)
            make.centerX.equalTo(view)
        }
        
        kakaoStoryButton.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(40)
            make.width.equalTo(80)
            make.height.equalTo(40)
            make.leading.equalTo(editButton.snp.trailing).offset(40)
        }
        
        chatLabel.snp.makeConstraints { make in
            make.top.equalTo(chatButton.snp.bottom).offset(16)
            make.width.equalTo(80)
            make.height.equalTo(40)
            make.leading.equalTo(chatButton.snp.leading).offset(0)
        }
        
        editLabel.snp.makeConstraints { make in
            make.top.equalTo(editButton.snp.bottom).offset(16)
            make.width.equalTo(80)
            make.height.equalTo(40)
            make.leading.equalTo(editButton.snp.leading).offset(0)
        }
        
        kakaoStoryLabel.snp.makeConstraints { make in
            make.top.equalTo(kakaoStoryButton.snp.bottom).offset(16)
            make.width.equalTo(80)
            make.height.equalTo(40)
            make.leading.equalTo(kakaoStoryButton.snp.leading).offset(0)
        }
    }
}
