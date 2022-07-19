//
//  SettingTableViewController.swift
//  TrendMedia
//
//  Created by 유연탁 on 2022/07/18.
//

import UIKit

class SettingTableViewController: UITableViewController {

    
    var birthdayFriends = ["뽀로로", "신데렐라", "피카츄", "짱구", "고래밥"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 80 //default 44
        
    }
    
    //섹션의 개수(옵션)
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "생일인 친구"
        } else if section == 1 {
            return "즐겨찾기"
        } else if section == 2 {
            return "친구 130명"
        }
        return "섹션"
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "푸터"
    }
    
    //1. 셀의 개수 (필수)
    //ex. 카톡 100명 -> 셀 100개, 3000명 -> 셀 3000개
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return birthdayFriends.count
        } else if section == 2 {
            return 10
        } else {
            return 3
        }
    }
    
    //2. 셀의 디자인과 데이터(필수)
    //ex. 카톡 이름, 프로필사진, 상태 메세지 등
    //재사용 매커니즘
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("cellforrowat", indexPath)
        
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "rightDetailCell")!
            
            cell.textLabel?.text = "2번 인덱스 텍스트"
            cell.textLabel?.textColor = .systemBlue
            cell.textLabel?.font = .boldSystemFont(ofSize: 15)
            cell.detailTextLabel?.text = "디테일 레이블"
            
            //indexPath.row % 2 == 0, 1
            
            cell.imageView?.image = indexPath.row % 2 == 0 ? UIImage(systemName: "star") : UIImage(systemName: "star.fill")
            cell.backgroundColor = indexPath.row % 2 == 0 ? .lightGray : .white
            return cell
            
        } else {
            
            // * 100
            let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell")!
            if indexPath.section == 0 {
                cell.textLabel?.text = birthdayFriends[indexPath.row]
                cell.textLabel?.textColor = .systemMint
                cell.textLabel?.font = .boldSystemFont(ofSize: 20)
            } else if indexPath.section == 1 {
                cell.textLabel?.text = "1번 인덱스 텍스트"
                cell.textLabel?.textColor = .systemPink
                cell.textLabel?.font = .boldSystemFont(ofSize: 20)
            }
            return cell
        }
    }
    
    //셀의 높이(옵션, 빈도 높은) (feat. tableView.rowHeight)
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
