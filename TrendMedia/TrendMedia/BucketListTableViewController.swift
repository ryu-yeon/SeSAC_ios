//
//  BucketListTableViewController.swift
//  TrendMedia
//
//  Created by 유연탁 on 2022/07/19.
//

import UIKit

class BucketListTableViewController: UITableViewController {

    static let identifier = "BucketListTableViewController"
    
    
    @IBOutlet var userTextField: UITextField!
    
    var list = ["범죄도시2", "탑건", "토르"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "버킷리스트"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))

        tableView.rowHeight = 80
        list.append("마녀")
        list.append("asd")
    }
    
    
    @objc func closeButtonClicked() {
        dismiss(animated: true)
    }
    
    @IBAction func userTextFieldReturn(_ sender: UITextField) {
        
        //case 1.
//        list.append(sender.text!)
//        tableView.reloadData()
        
        
        //case 2. if let
        if let value = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines), !value.isEmpty, (2...6).contains(value.count) {
            list.append(value)
            tableView.reloadData()
        } else {
            //토스트 메시지 띄우기
        }
        
        //case 3. guard 구문으로 활용
        guard let value = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines), (2...6).contains(value.count) else {
            //Alert, Toast를 통해서 빈칼을 입력했다 글자수가 많다
            return
        }
        list.append(value)
        tableView.reloadData()
        
//        tableView.reloadSections(IndexSet(, with: <#T##UITableView.RowAnimation#>)
//        tableView.reloadRows(at: [IndexPath(row: 0, section: 0), IndexPath(row: 1, section: 0)], with: .fade)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: BucketListTableViewCell.identifier, for: indexPath) as! BucketListTableViewCell //as? 타입 캐스팅
        
        cell.bucketlistLabel.text = list[indexPath.row]
        cell.bucketlistLabel.font = .boldSystemFont(ofSize: 18)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //배열 삭제 후 테이블뷰 갱신
            list.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    

}
