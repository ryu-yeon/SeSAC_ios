//
//  SettingViewController.swift
//  Diary
//
//  Created by 유연탁 on 2022/08/25.
//

import UIKit

class SettingViewController: BaseViewController {
    
    let mainView = SettingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func configure() {
        navigationItem.title = "Setting"
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.reusableIdentifier)
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.reusableIdentifier, for: indexPath) as? SettingTableViewCell else { return SettingTableViewCell() }
        
        return cell
        
    }
}
