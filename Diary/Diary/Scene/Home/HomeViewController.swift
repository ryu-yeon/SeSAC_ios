//
//  HomeViewController.swift
//  Diary
//
//  Created by 유연탁 on 2022/08/24.
//

import UIKit

import RealmSwift
import CoreMIDI

class HomeViewController: BaseViewController {
    
    let mainView = HomeView()
    
    let localRealm = try! Realm()
    
    let format = DateFormatter()
    
    var tasks: Results<UserDiary>! {
        didSet {
            mainView.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchRealm()
    }
    
    override func configure() {
        navigationItem.title = "Home"

        let sortButton = UIBarButtonItem(title: "정렬", style: .plain, target: self, action: #selector(sortButtonClicked))
        let filterButton = UIBarButtonItem(title: "필터", style: .plain, target: self, action: #selector(filterButtonClicked))
        
        let settingButton = UIBarButtonItem(title: "설정", style: .plain, target: self, action: #selector(settingButtonClicked))
        
        navigationItem.leftBarButtonItems = [sortButton, filterButton, settingButton]
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonClicked))
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.reusableIdentifier)
        
        format.dateFormat = "yyyy.MM.dd hh:mm"
    }
    
    @objc func plusButtonClicked() {
        let vc = WriteViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    @objc func sortButtonClicked() {
        tasks = localRealm.objects(UserDiary.self).sorted(byKeyPath: "registerDate", ascending: true)
    }
    
    @objc func filterButtonClicked() {
//        tasks = localRealm.objects(UserDiary.self).sorted(byKeyPath: "diaryTitle CONTAINS[c] '일기'")
    }
    
    @objc func settingButtonClicked() {
        let vc = SettingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func fetchRealm() {
        tasks = localRealm.objects(UserDiary.self).sorted(byKeyPath: "diaryTitle", ascending: true)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.reusableIdentifier, for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }

        cell.titleLabel.text = tasks[indexPath.row].diaryTitle
        cell.dateLabel.text = self.format.string(from: tasks[indexPath.row].diaryDate)
        cell.diaryImageView.image = loadImageFromDocument(fileName: "\(tasks[indexPath.row].objectId).jpg")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = tasks?[indexPath.row]
            try! localRealm.write({
                localRealm.delete(item!)
                removeImageFromDocument(fileName: "\(tasks[indexPath.row].objectId).jpg")
            })
        }
        fetchRealm()
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let favorite = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
            
            try! self.localRealm.write {
                self.tasks[indexPath.row].favorite = !self.tasks[indexPath.row].favorite
                
                self.fetchRealm()
            }
        }
        
        let image = tasks[indexPath.row].favorite ? "star.fill" : "star"
        favorite.image = UIImage(systemName: image)
        
        return UISwipeActionsConfiguration(actions: [favorite])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let remove = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
            
            try! self.localRealm.write {
                self.localRealm.delete(self.tasks[indexPath.row])
                self.fetchRealm()
            }
        }
        
        remove.backgroundColor = .red
        remove.image = UIImage(systemName: "trash.fill")
        
        return UISwipeActionsConfiguration(actions: [remove])
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
