//
//  PopUpView.swift
//  Memo
//
//  Created by 유연탁 on 2022/08/31.
//

import UIKit

import SnapKit

class PopUpView: BaseView {
    
    let viewContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .popupViewContainerBackgroundColor
        return view
    }()
    
    let welcomeLabel: UILabel = {
        let view = UILabel()
        let ment = """
        처음 오셨군요!
        환영합니다:)
        
        당신만의 메모를 작성하고
        관리해보세요!
        """
        view.text = ment
        view.numberOfLines = 5
        view.textColor = .textColor
        view.font = .boldSystemFont(ofSize: 20)
        return view
    }()
    
    let okButton: UIButton = {
        let view = UIButton()
        view.setTitleColor(.label, for: .normal)
        view.setAttributedTitle(NSAttributedString(string: "확인", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]), for: .normal)
        view.backgroundColor = .backgroundColor
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .popupViewBackgroundColor
        [viewContainer, welcomeLabel, okButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        viewContainer.snp.makeConstraints { make in
            make.center.equalTo(self)
            make.width.equalTo(self).multipliedBy(0.6)
            make.height.equalTo(self).multipliedBy(0.3)
        }
        
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(viewContainer.snp.top).offset(16)
            make.leading.equalTo(viewContainer.snp.leading).inset(20)
            make.trailing.equalTo(viewContainer.snp.trailing).inset(20)
            make.height.equalTo(viewContainer.snp.height).multipliedBy(0.6)
        }
        
        okButton.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(16)
            make.leading.equalTo(welcomeLabel.snp.leading)
            make.trailing.equalTo(welcomeLabel.snp.trailing)
            make.bottom.equalTo(viewContainer.snp.bottom).inset(20)            
        }
    }
}
