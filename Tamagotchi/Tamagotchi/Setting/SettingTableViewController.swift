//
//  SettingTableViewController.swift
//  Tamagotchi
//
//  Created by 유연탁 on 2022/07/22.
//

import UIKit

class SettingTableViewController: UITableViewController {
    
    var nickname: String?
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .myBackgroundColor
        
        nickname = UserDefaultsHelper.standard.nickname
        setNavigationBar(title: "설정")
    }
    
    //MARK: - ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nickname = UserDefaultsHelper.standard.nickname
        tableView.reloadData()
    }
    
    //MARK: - 테이블 뷰 셀 개수 설정
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    //MARK: - 테이블 뷰 셀 설정
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.rowHeight = 50
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.reusableIenditifier, for: indexPath) as! SettingTableViewCell
        
        cell.separatorInset = .zero
        cell.backgroundColor = .myBackgroundColor
        cell.setDesign(row: indexPath.row, nickname: nickname ?? "대장님")
 
        return cell
    }
    
    //MARK: - 테이블 뷰 셀 선택 설정
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            let sb = UIStoryboard(name: StoryboardName.setting, bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: EditNicknameViewController.reusableIenditifier) as! EditNicknameViewController
            navigationController?.pushViewController(vc, animated: true)
            
        } else if indexPath.row == 1 {
            let sb = UIStoryboard(name: StoryboardName.main, bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: TamagotchiCollectionViewController.reusableIenditifier) as! TamagotchiCollectionViewController
            navigationController?.pushViewController(vc, animated: true)
    
        } else {
            resetAlert()
        }
    }
    
    //MARK: - 데이터 초기화 Alert 설정
    func resetAlert() {
        let alert = UIAlertController(title: "데이터 초기화", message: "정말 다시 처음부터 시작하실 건가요?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "웅", style: .destructive) { alert in
            UserDefaultsHelper.standard.start = false
            UserDefaultsHelper.standard.nickname = "대장님"
            UserDefaultsHelper.standard.tamagotchiNumber = 0
            UserDefaultsHelper.standard.data = [1, 0, 0]
            
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let sceneDelegate = windowScene?.delegate as? SceneDelegate
            
            let sb = UIStoryboard(name: StoryboardName.main, bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: TamagotchiCollectionViewController.reusableIenditifier) as! TamagotchiCollectionViewController
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
