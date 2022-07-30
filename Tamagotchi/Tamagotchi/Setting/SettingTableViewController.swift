//
//  SettingTableViewController.swift
//  Tamagotchi
//
//  Created by 유연탁 on 2022/07/22.
//

import UIKit

class SettingTableViewController: UITableViewController {
    
    static let identifier = "SettingTableViewController"
    var nickname: String?
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .myBackgroundColor
        
        nickname = UserDefaults.standard.string(forKey: "nickname") ?? ""
        setNavigationBar(title: "설정")
    }
    
    //MARK: - ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nickname = UserDefaults.standard.string(forKey: "nickname") ?? ""
        tableView.reloadData()
    }
    
    //MARK: - 테이블 뷰 셀 개수 설정
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    //MARK: - 테이블 뷰 셀 설정
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.rowHeight = 50
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as! SettingTableViewCell
        
        cell.separatorInset = .zero
        cell.backgroundColor = .myBackgroundColor
        cell.setDesign(row: indexPath.row, nickname: nickname ?? "대장님")
 
        return cell
    }
    
    //MARK: - 테이블 뷰 셀 선택 설정
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            let sb = UIStoryboard(name: "Setting", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: EditNicknameViewController.identifier) as! EditNicknameViewController
            navigationController?.pushViewController(vc, animated: true)
            
        } else if indexPath.row == 1 {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: TamagotchiCollectionViewController.identifier) as! TamagotchiCollectionViewController
            navigationController?.pushViewController(vc, animated: true)
    
        } else {
            resetAlert()
        }
    }
    
    //MARK: - 데이터 초기화 Alert 설정
    func resetAlert() {
        let alert = UIAlertController(title: "데이터 초기화", message: "정말 다시 처음부터 시작하실 건가요?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "웅", style: .destructive) { alert in
            UserDefaults.standard.set(false, forKey: "start")
            UserDefaults.standard.set("대장님", forKey: "nickname")
            UserDefaults.standard.set(0, forKey: "tamagotchi")
            UserDefaults.standard.set([1,0,0], forKey: "data")
            
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let sceneDelegate = windowScene?.delegate as? SceneDelegate
            
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: TamagotchiCollectionViewController.identifier) as! TamagotchiCollectionViewController
            let nav = UINavigationController(rootViewController: vc)
            sceneDelegate?.window?.rootViewController = nav
            sceneDelegate?.window?.makeKeyAndVisible()
        }
        let cancel = UIAlertAction(title: "아냐!", style: .cancel)
        
        alert.addAction(cancel)
        alert.addAction(ok)

        present(alert, animated: true)
    }
}
