//
//  ViewController.swift
//  SeSacWeek6
//
//  Created by 유연탁 on 2022/08/08.
//

import UIKit

/*
 1.html tag <> </> 기능 활용
 2. 문자열 대체 메서드
response에서 처리하는 것과 보여지는 셀 등에서 처리하는 것의 차이는!?
 */

/*
 TableView automaticDimension
 - 컨넨츠 양에 따라서 셀 높이가 자유롭게
 - 조건 : 레이블 numberIfLines 0
 - 조건: tableView Height automaticDimension
 - 조건: 레이아웃
 
 */

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var blogList: [String] = []
    private var cafeList: [String] = []
    
    private var isExpanded = false // false 2줄, true 0으로!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(#function, "START")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension // 모든 섹션의 셀에 대해서 유동적!
        
        searchBlog(searchText: "고래밥")
        print(#function, "END")
        
    }
    
    private func searchBlog(searchText: String) {
        KakaoAPIManager.shared.callRequest(type: EndPoint.blog, searchText: searchText) { json in
            
            for item in json["documents"].arrayValue {
                let value = item["contents"].stringValue.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
                self.blogList.append(value)
            }
            self.searchCafe(searchText: searchText)
    
        }
    }
    
    private func searchCafe(searchText: String) {
        KakaoAPIManager.shared.callRequest(type: EndPoint.cafe, searchText: searchText) { json in
            
            for item in json["documents"].arrayValue {
                
                let value = item["contents"].stringValue.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
                
                self.cafeList.append(value)
            }
//            print(self.cafeList)
//            print(self.blogList)
            
            self.tableView.reloadData()
            
            
        }
    }
    
    @IBAction func barButtonClicked(_ sender: UIBarButtonItem) {
        isExpanded = !isExpanded
        tableView.reloadData()
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? blogList.count : cafeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else { return UITableViewCell()}
        
        cell.contentsLabel.numberOfLines = isExpanded ? 0 : 2
        cell.contentsLabel.text = indexPath.section == 0 ? blogList[indexPath.row] : cafeList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "블로그 검색결과" : "카페 검색결과"
    }
        
}
