//
//  SettingViewController.swift
//  CardWeather
//
//  Created by 유연탁 on 2022/08/13.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var settingTableView: UITableView!
    
    let settingList: [String] = ["지역", "온도"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "설정"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(goToBack))
        
        settingTableView.delegate = self
        settingTableView.dataSource = self
        settingTableView.register(UINib(nibName: "SettingTableViewCell", bundle: nil), forCellReuseIdentifier: SettingTableViewCell.reusableidentifier)
        
    }
    
    @objc func goToBack() {
        dismiss(animated: true)
    }

}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingList.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.reusableidentifier, for: indexPath) as! SettingTableViewCell
        
        cell.settingLabel.text = settingList[indexPath.row]
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 1 {
            let sb = UIStoryboard(name: "Setting", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: PopUpViewController.reusableidentifier) as! PopUpViewController
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
        } else {
            
        }
        
    }
    
}
