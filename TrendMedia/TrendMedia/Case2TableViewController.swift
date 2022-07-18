//
//  Case2TableViewController.swift
//  TrendMedia
//
//  Created by 유연탁 on 2022/07/18.
//

import UIKit

class Case2TableViewController: UITableViewController {

    let settingArray: [[String]] = [["전체 설정", "공지사항", "실험실", "버전정보"],
                               ["개인 설정", "개인/보안", "알림", "채팅", "멀티프로필"],
                               ["기타", "고객센터/도움말"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        designNavigationBar()
    }
    
    func designNavigationBar() {
        self.navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = .black
        self.navigationController?.navigationBar.standardAppearance.backgroundColor = .black
        self.navigationController?.navigationBar.scrollEdgeAppearance?.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.title = "설정"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return settingArray.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return settingArray[section][0]
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {

        for section in 0..<settingArray.count {
            tableView.headerView(forSection: section)?.textLabel?.font = .boldSystemFont(ofSize: 20)
            tableView.headerView(forSection: section)?.frame = .init(x: 0, y: 0, width: 100, height: 100)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return settingArray[section].count - 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell")!

        cell.textLabel?.text = settingArray[indexPath.section][indexPath.row + 1]
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = .systemFont(ofSize: 14)

        return cell
    }
    
}
