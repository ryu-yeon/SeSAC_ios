//
//  SettingTableViewCell.swift
//  Tamagotchi
//
//  Created by 유연탁 on 2022/07/22.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    static let identifier = "SettingTableViewCell"
    let settingListImage: [String] = ["pencil", "moon.fill", "arrow.clockwise"]
    let settingList: [String] = ["내 이름 설정하기", "다마고치 변경하기", "데이터 초기화"]
    
    @IBOutlet var settingImageView: UIImageView!
    @IBOutlet var settingLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    @IBOutlet var rightArrowImageView: UIImageView!
    
    //MARK: - 테이블 뷰 셀 UI 설정
    func setDesign(row: Int, nickname: String) {
        settingImageView.image = UIImage(systemName: settingListImage[row])
        settingImageView.tintColor = UIColor(named: "mainColor")
        
        settingLabel.text = settingList[row]
        settingLabel.font = .boldSystemFont(ofSize: 15)
        settingLabel.textColor = UIColor(named: "textColor")
        
        rightArrowImageView.image = UIImage(systemName: "chevron.forward")
        rightArrowImageView.tintColor = UIColor(named: "mainColor")
        
        if row == 0 {
            valueLabel.text = nickname
            valueLabel.font = .systemFont(ofSize: 13)
            valueLabel.textAlignment = .right
            valueLabel.textColor = UIColor(named: "mainColor")
        } else {
            valueLabel.text = ""
        }
    }
}
