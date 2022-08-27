//
//  HomeViewController.swift
//  Diary
//
//  Created by 유연탁 on 2022/08/24.
//

import UIKit

import FSCalendar
import RealmSwift

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
        let filterButton = UIBarButtonItem(title: "필터", style: .plain, target: self, action: #selector(filterButtonClicked))
        
        let settingButton = UIBarButtonItem(title: "설정", style: .plain, target: self, action: #selector(settingButtonClicked))
        
        navigationItem.leftBarButtonItems = [sortButton, filterButton, settingButton]
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonClicked))
        
        mainView.calendar.delegate = self
        mainView.calendar.dataSource = self
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.reusableIdentifier)
        
//        format.dateFormat = "yyyy.MM.dd hh:mm"
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
    
    @objc func filterButtonClicked() {
        tasks = repository.fetchFilter()
    }
    
    @objc func settingButtonClicked() {
        let vc = SettingViewController()
        navigationController?.pushViewController(vc, animated: true)
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
        cell.dateLabel.text = self.formatter.string(from: tasks[indexPath.row].diaryDate)
        cell.diaryImageView.image = loadImageFromDocument(fileName: "\(tasks[indexPath.row].objectId).jpg")
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            let item = tasks?[indexPath.row]
//            try! repository.localRealm.write({
//                repository.localRealm.delete(item!)
//                removeImageFromDocument(fileName: "\(tasks[indexPath.row].objectId).jpg")
//            })
//        }
//        fetchRealm()
//    }
    
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

extension HomeViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return repository.fetchDate(date: date).count
    }
    
//    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
//        return "새싹"
//    }
//
//    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
//        return UIImage(systemName: "star.fill")
//    }
    
//    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
//        <#code#>
//    }

    //date: yyyyMMdd hh:mm:ss => dateformatter
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {

        return formatter.string(from: date) == "220907" ? "오프라인 모임" : nil
    }

    // 100 -> 25일 3 -> 3 = >
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        tasks = repository.fetchDate(date: date)
    }
}
