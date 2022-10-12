//
//  MemoListViewController.swift
//  Memo
//
//  Created by 유연탁 on 2022/08/31.
//

import UIKit

import RealmSwift
import Toast

enum Tasks: Int {
    case fixed = 0
    case normal = 1
    case search = 2
}

class MemoListViewController: BaseViewController {
    
    private let mainView = MemoListView()
    
    private let repository = MemoRepository()
    
    private let numberFormat: NumberFormatter = {
        let format = NumberFormatter()
        format.numberStyle = .decimal
        return format
    }()
    
    let dateFormat: DateFormatter = {
        let format = DateFormatter()
        format.locale = Locale(identifier: "ko_KR")
        return format
    }()
    
    private var tasks: [Results<Memo>?] = [nil, nil, nil]
    
    private var searchText: String?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if !UserDefaultHelper.standard.start {
            UserDefaultHelper.standard.start = true
            let vc = PopUpViewController()
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
        }
        
        setToolbarButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        updateTasks()
        mainView.tableView.reloadData()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.backButtonTitle = "메모"
        setTitle()
    }
    
    override func configure() {
        
        setSearchController()
        setNavigtaionBar()
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(MemoListTableViewCell.self, forCellReuseIdentifier: MemoListTableViewCell.reusableIdentifier)
    }
    
    @objc func writeButtonClicked() {
        let vc = WriteViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setNavigtaionBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .viewBackgroundColor
        appearance.titleTextAttributes = [.foregroundColor: UIColor.textColor]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.textColor]
        
        navigationController?.navigationBar.tintColor = .pointColor
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setTitle() {
        let memoCount = numberFormat.string(for: (tasks[Tasks.fixed.rawValue]?.count ?? 0) + (tasks[Tasks.normal.rawValue]?.count ?? 0))
        navigationItem.title = (memoCount ?? "0") + "개의 메모"
    }
    
    private func setDateFormat(date: Date) -> String {
        if Calendar.current.isDateInToday(date) {
            dateFormat.dateFormat = "a hh:mm"
            
        } else if NSCalendar.current.component(.weekOfYear, from: date) == NSCalendar.current.component(.weekOfYear, from: Date()) {
            dateFormat.dateFormat = "EEEE"
        } else {
            dateFormat.dateFormat = "yyyy. MM. dd a hh:mm"
        }
        return dateFormat.string(from: date)
    }
    
    private func setToolbarButton() {

        if #available(iOS 14.0, *) {
            let view = UIView()
            view.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            let writeButton = UIButton()
            writeButton.frame = CGRect(x: 0, y: -5, width: 30, height: 30)
            writeButton.setImage(UIImage.writeImage, for: .normal)
            writeButton.contentVerticalAlignment = .fill
            writeButton.contentHorizontalAlignment = .fill
            
            view.addSubview(writeButton)
            writeButton.addTarget(self, action: #selector(writeButtonClicked), for: .touchUpInside)
            mainView.toolBar.items = [UIBarButtonItem.flexibleSpace(),  UIBarButtonItem(customView: view)]
        } else {
            let view = UIView()
            view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 30)
            let writeButton = UIButton()
            writeButton.frame = CGRect(x: UIScreen.main.bounds.width - 60, y: -5, width: 30, height: 30)
            writeButton.setImage(UIImage.writeImage, for: .normal)
            writeButton.contentVerticalAlignment = .fill
            writeButton.contentHorizontalAlignment = .fill
            
            view.addSubview(writeButton)
            writeButton.addTarget(self, action: #selector(writeButtonClicked), for: .touchUpInside)
            mainView.toolBar.items = [UIBarButtonItem(customView: view)]
        }
    }
    
    private func setSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        
        navigationController?.navigationBar.backgroundColor = .viewBackgroundColor
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.largeTitleDisplayMode = .always

        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "검색"
        searchController.searchBar.setValue("취소", forKey: "cancelButtonText")
    }
    
    private func updateTasks() {
        tasks[Tasks.fixed.rawValue] = repository.fetchFiterSort(text: "isFixed = true", sort: "registerDate")
        tasks[Tasks.normal.rawValue] = repository.fetchFiterSort(text: "isFixed = false", sort: "registerDate")
    }
    
    private func highlightText(text: String, searchText: String) ->  NSMutableAttributedString {
        
        let attributeString = NSMutableAttributedString(string: text)
        
        attributeString.addAttribute(.foregroundColor, value: UIColor.pointColor, range: (text as NSString).range(of: searchText))
        
        return attributeString
    }
}

extension MemoListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == Tasks.search.rawValue {
            return tasks[section]?.count ?? 0
        } else if tasks[Tasks.search.rawValue] == nil {
            return tasks[section]?.count ?? 0
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MemoListTableViewCell.reusableIdentifier, for: indexPath) as? MemoListTableViewCell else { return UITableViewCell() }

        if indexPath.section != Tasks.search.rawValue {
            guard let tasks = tasks[indexPath.section] else { return UITableViewCell() }
            
            cell.titleLabel.text = tasks[indexPath.row].title
            cell.contentLabel.text = tasks[indexPath.row].content ?? "추가 텍스트 없음"
            cell.dateLabel.text = setDateFormat(date: tasks[indexPath.row].registerDate)
        } else {
            guard let tasks = tasks[Tasks.search.rawValue] else { return UITableViewCell() }
            
            cell.titleLabel.attributedText = highlightText(text: tasks[indexPath.row].title, searchText: searchText ?? "")

            if let content = tasks[indexPath.row].content {
                cell.contentLabel.attributedText = highlightText(text: content, searchText: searchText ?? "")
            } else {
                cell.contentLabel.text = "추가 텍스트 없음"
            }
            cell.dateLabel.text = setDateFormat(date: tasks[indexPath.row].registerDate)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = WriteViewController()
        
        guard let tasks = tasks[indexPath.section] else { return }
        
        if indexPath.section == Tasks.search.rawValue {
            navigationItem.backButtonTitle = "검색"
        }
        vc.task = tasks[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let fixButton = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
            
            guard let tasks = self.tasks[indexPath.section] else { return }
            
            if indexPath.section == Tasks.fixed.rawValue {
                                
                self.repository.updateIsFixed(task: tasks[indexPath.row])
            } else if indexPath.section == Tasks.normal.rawValue {
                if (self.tasks[Tasks.fixed.rawValue]?.count ?? 0) < 5 {
                    
                    self.repository.updateIsFixed(task: tasks[indexPath.row])
                    self.mainView.tableView.reloadData()
                } else {
                    self.view.makeToast("최대 5개까지 메모를 고정할 수 있습니다.", duration: 2.0, position: .center, style: ToastStyle())
                }
            } else {
                
                if tasks[indexPath.row].isFixed == true {
                    
                    self.repository.updateIsFixed(task: tasks[indexPath.row])
                    
                    self.mainView.tableView.reloadData()
                } else {
                    if (self.tasks[Tasks.fixed.rawValue]?.count ?? 0) < 5 {
                        self.repository.updateIsFixed(task: tasks[indexPath.row])
                        
                        self.mainView.tableView.reloadData()
                    } else {
                        self.view.makeToast("최대 5개까지 메모를 고정할 수 있습니다.", duration: 2.0, position: .center, style: ToastStyle())
                    }
                }
            }
            self.mainView.tableView.reloadData()
        }
        
        fixButton.image = tasks[indexPath.section]?[indexPath.row].isFixed == true ? .fixedImage : .unfixedImage
        fixButton.backgroundColor = .pointColor
        return UISwipeActionsConfiguration(actions: [fixButton])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let removeButton = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
            
            let alert = UIAlertController(title: "삭제", message: "메모를 정말 삭제하시겠습니까?", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "확인", style: .destructive) { alert in
                
                guard let tasks = self.tasks[indexPath.section] else { return }
                
                self.repository.deleteTask(task: tasks[indexPath.row])
                self.setTitle()
                self.mainView.tableView.reloadData()
            }
            
            let cancel = UIAlertAction(title: "취소", style: .default)
            
            [ok, cancel].forEach {
                alert.addAction($0)
            }
            self.present(alert, animated: true)
        }
        
        removeButton.image = .removeImage
        removeButton.backgroundColor = .removeColor
        return UISwipeActionsConfiguration(actions: [removeButton])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView()
        let label = UILabel()
        label.textColor = .textColor
        label.frame = CGRect(x: 0, y: 0, width: 300, height: 30)
        if section == Tasks.fixed.rawValue {
            label.text = "고정된 메모"
        } else if section == Tasks.normal.rawValue{
            label.text = "메모"
        } else {
            label.text = "\(tasks[Tasks.search.rawValue]?.count ?? 0)개 찾음"
        }
        label.font = .boldSystemFont(ofSize: 28)
        view.addSubview(label)
        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section != Tasks.search.rawValue {
            if tasks[Tasks.search.rawValue] != nil || tasks[section]?.count == 0 {
                return 0
            }
        } else if tasks[Tasks.search.rawValue] == nil {
            return 0
        }
        return 40
    }
}

extension MemoListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, text != "" {
            searchText = text
            tasks[Tasks.search.rawValue] = repository.fetchFiterSort(text: "title CONTAINS[c] '\(text)' || content CONTAINS[c] '\(text)'", sort: "registerDate")
        } else {
            tasks[Tasks.search.rawValue] = nil
        }
        mainView.tableView.reloadData()
    }
}
