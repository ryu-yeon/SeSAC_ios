//
//  HomeViewController.swift
//  Diary
//
//  Created by 유연탁 on 2022/08/24.
//

import UIKit

import FSCalendar
import RealmSwift
import SwiftUI

class HomeViewController: BaseViewController {
    
    let mainView = HomeView()
    
    let repository = UserDiaryRepository()
    
    let formatter: DateFormatter = {
        let format = DateFormatter()
        format.dateFormat = "yyMMdd"
        return format
    }()
    
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
        
        navigationItem.leftBarButtonItems = [sortButton]
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonClicked))
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.reusableIdentifier)

    }
    
    @objc func plusButtonClicked() {
        let vc = WriteViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    @objc func sortButtonClicked() {
        tasks = repository.fetchSort("registerDate")
    }

    
    func fetchRealm() {
        tasks = repository.fetch()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.reusableIdentifier, for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }

        cell.titleLabel.text = tasks[indexPath.row].diaryTitle
        cell.subTitleLabel.text = tasks[indexPath.row].subTitle
        cell.dateLabel.text = self.formatter.string(from: tasks[indexPath.row].diaryDate)
        cell.contentLabel.text = tasks[indexPath.row].diaryContent
        cell.diaryImageView.image = loadImageFromDocument(fileName: "\(tasks[indexPath.row].objectId).jpg")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let favorite = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
            
            self.repository.updateFavorite(task: self.tasks[indexPath.row])
            self.fetchRealm()

        }
        
        let image = tasks[indexPath.row].favorite ? "star.fill" : "star"
        favorite.image = UIImage(systemName: image)
        
        return UISwipeActionsConfiguration(actions: [favorite])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let remove = UIContextualAction(style: .normal, title: nil) { [self] action, view, completionHandler in
            
            let task = self.tasks[indexPath.row]
            
            self.repository.deleteTask(task: task)
            self.fetchRealm()
        }
        
        remove.backgroundColor = .red
        remove.image = UIImage(systemName: "trash.fill")
        
        return UISwipeActionsConfiguration(actions: [remove])
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.tasks = self.repository.fetchFilter(text: searchBar.text ?? "")
        self.mainView.tableView.reloadData()
        view.endEditing(true)
    }
}
