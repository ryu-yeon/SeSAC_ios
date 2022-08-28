//
//  CaledarViewController.swift
//  Diary
//
//  Created by 유연탁 on 2022/08/27.
//

import UIKit

import FSCalendar

class CalendarViewController: BaseViewController {
    
    let mainView = CalendarView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configure() {
        navigationItem.title = "Calendar"
        mainView.calendar.delegate = self
        mainView.calendar.dataSource = self
    }
}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
//    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
//        return 2
//    }
    
}
