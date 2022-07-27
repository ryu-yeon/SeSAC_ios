//
//  BucketListTableViewController.swift
//  TrendMedia
//
//  Created by 유연탁 on 2022/07/19.
//

import UIKit

struct Todo {
    var title: String
    var done: Bool
}

class BucketListTableViewController: UITableViewController {

    static let identifier = "BucketListTableViewController"
    
    //클래스는 ReferenceType -> 인스턴스 자체를 변경하지 않는 이사 한 번만 될거다!
    //IBOutler ViewDidLoad 호출 되기 직전에 nil이 아닌지 nil인지 알수있음!
    @IBOutlet var userTextField: UITextField! {
        didSet {
            userTextField.textAlignment = .center
            userTextField.font = .boldSystemFont(ofSize: 22)
            userTextField.textColor = .systemRed
            print("텍스트필드 DidSet")
        }
    }
    
    var select: String?
    
    //list 프로퍼티가 추가, 삭제 등 변경 되고 나서 테이블뷰를 항상 갱신!
    var list = [Todo(title: "범죄도시2", done: false), Todo(title: "탑건", done: false)] {
        didSet {
            tableView.reloadData()
            print("list가 변경됨 \(list), \(oldValue)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "버킷리스트"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))

        tableView.rowHeight = 80
        
        userTextField.placeholder = "\(select ?? "")를 입력해주세요!"
    }
    
    
    @objc func closeButtonClicked() {
        dismiss(animated: true)
    }
    
    @IBAction func userTextFieldReturn(_ sender: UITextField) {
        
//        //case 1.
////        list.append(sender.text!)
////        tableView.reloadData()
//
//        //case 2. if let
//        if let value = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines), !value.isEmpty, (2...6).contains(value.count) {
//            list.append(value)
//            tableView.reloadData()
//        } else {
//            //토스트 메시지 띄우기
//        }
//
//        //case 3. guard 구문으로 활용
        guard let value = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines), (2...6).contains(value.count) else {
            //Alert, Toast를 통해서 빈칼을 입력했다 글자수가 많다
            return
        }
        list.append(Todo(title: value, done: false))
//        tableView.reloadData()
        
//        tableView.reloadSections(IndexSet(, with: <#T##UITableView.RowAnimation#>)
//        tableView.reloadRows(at: [IndexPath(row: 0, section: 0), IndexPath(row: 1, section: 0)], with: .fade)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: BucketListTableViewCell.identifier, for: indexPath) as! BucketListTableViewCell //as? 타입 캐스팅
        
        cell.bucketlistLabel.text = list[indexPath.row].title
        cell.bucketlistLabel.font = .boldSystemFont(ofSize: 18)
        cell.checkButton.tag = indexPath.row
        cell.checkButton.addTarget(self, action: #selector(checkboxButtonClicked(sender:)), for: .touchUpInside)
        let value = list[indexPath.row].done ? "checkmark.square.fill" : "checkmark.square"
        cell.checkButton.setImage(UIImage(systemName: value), for: .normal)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //배열 삭제 후 테이블뷰 갱신
            list.remove(at: indexPath.row)
        }
    }
    
    @objc func checkboxButtonClicked(sender: UIButton) {
        print("\(sender.tag)버튼 클릭!")
        
        list[sender.tag].done = !list[sender.tag].done
        //배열 인덱슬를 찾아서 done을 바꿔야 된다! 그리고 테이블뷰 갱신 해야한다!
        
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .fade)
        
        //재사용 셀 오류 확인용 코드
//        sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        
    }

}
