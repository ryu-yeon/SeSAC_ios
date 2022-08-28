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
        mainView.userSearchBar.delegate = self
    }
    
    @objc func plusButtonClicked() {
        let vc = WriteViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    @objc func sortButtonClicked() {
        sortAlert()
        
    }
    
    func sortAlert() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let titleSort = UIAlertAction(title: "제목순", style: .default) { alert in
            self.tasks = self.repository.fetchSort("diaryTitle")
        }
        let dateSort = UIAlertAction(title: "등록순", style: .default) { alert in
            self.tasks = self.repository.fetchSort("registerDate")
        }
        let cancle = UIAlertAction(title: "취소", style: .cancel)
        
        [titleSort, dateSort, cancle].forEach {
            alert.addAction($0)
        }
        present(alert, animated: true)
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
            tableView.reloadData()

        }
        
        let image = tasks[indexPath.row].favorite ? "star.fill" : "star"
        favorite.image = UIImage(systemName: image)
        
        return UISwipeActionsConfiguration(actions: [favorite])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let remove = UIContextualAction(style: .normal, title: nil) { [self] action, view, completionHandler in
            
            let task = self.tasks[indexPath.row]
            
            self.repository.deleteTask(task: task)
            tableView.reloadData()
        }
        
        remove.backgroundColor = .red
        remove.image = UIImage(systemName: "trash.fill")
        
        return UISwipeActionsConfiguration(actions: [remove])
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            self.tasks = self.repository.fetch()
        }
        else {
            self.tasks = self.repository.fetchFilter(text: searchBar.text ?? "")
        }
        self.mainView.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }

}
