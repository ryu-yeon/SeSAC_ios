//
//  CalendarViewController.swift
//  Diary
//
//  Created by 유연탁 on 2022/08/27.
//

import UIKit

import FSCalendar
import RealmSwift

class CalendarViewController: BaseViewController {
    
    let mainView = CalendarView()
    
    let repository = UserDiaryRepository()
    
    var tasks: Results<UserDiary>?
    
    let formatter: DateFormatter = {
        let format = DateFormatter()
        format.dateFormat = "yyMMdd"
        return format
    }()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.calendar.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configure() {
        navigationItem.title = "Calendar"
        mainView.calendar.delegate = self
        mainView.calendar.dataSource = self
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(CalendarTableViewCell.self, forCellReuseIdentifier: CalendarTableViewCell.reusableIdentifier)
    }
}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {

    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return repository.fetchDate(date: date).count
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        tasks = repository.fetchDate(date: date)
        mainView.tableView.reloadData()
    }
}

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CalendarTableViewCell.reusableIdentifier, for: indexPath) as? CalendarTableViewCell else { return UITableViewCell() }

        
        cell.titleLabel.text = tasks?[indexPath.row].diaryTitle
        cell.subTitleLabel.text = tasks?[indexPath.row].subTitle
        cell.contentLabel.text = tasks?[indexPath.row].diaryContent
        cell.diaryImageView.image = loadImageFromDocument(fileName: "\(tasks?[indexPath.row].objectId).jpg")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
