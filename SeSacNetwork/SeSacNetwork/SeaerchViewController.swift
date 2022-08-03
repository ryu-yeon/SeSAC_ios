//
//  ViewController.swift
//  SeSacNetwork
//
//  Created by 유연탁 on 2022/07/27.
//

import UIKit


import Alamofire
import SwiftyJSON

/*
 Swift Protocol
 - Delegate
 - Datasource
 
 1. 왼팔/오른팔
 2. 테이블뷰 아웃렛 연결
 3. 1 + 2
 */

/*
 
 각 hso value -> list -> 테이블뷰 갱신
 서버의 응답이 몇개인지 모를 경우에는?
 
 */



class SearchViewController: UIViewController, ViewPresentableProtocol, UITableViewDelegate, UITableViewDataSource {
    
    var navigationTitleString: String = ""
    
    var backgroundColor: UIColor = .white
    
    static var identifier: String = "SearchViewController"
    
//    let yesterday = Date() - 24 * 60 * 60
//    let yesterday = Date(timeIntervalSinceNow: -24 * 60 * 60)
    let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
    let format = DateFormatter()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var searchTableView: UITableView!

    //BoxOffice 배열
    var list: [BoxOfficeModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        format.dateFormat = "yyyyMMdd"
        
        let date = format.string(from: yesterday!)

        
        
        //연결고리 작업: 테이블뷰가 해야 할 역할 > 뷰 컨드롤러에게 요청
        searchTableView.delegate = self
        searchTableView.dataSource = self
        //테이블뷰가 사용할 테이블뷰 셀(XIB) 등록
        //XIB: xml interface builder <= NIBB
        searchTableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: ListTableViewCell.reuseIdentifier)
        
        searchBar.delegate = self
        
        //네트워크 통신: 서버 점검 등에 대한 예외 처리
        //네트워크가 느린 환경 테스트
        // 실기기 테스트 시 Condition 조절 가능!
        // 시뮬레이터에서도 가능! (추가 설치)
        
        requestBoxOffice(text: date)
    }
    
    func configureView() {
        searchTableView.backgroundColor = .clear
        searchTableView.separatorColor = .clear
        searchTableView.rowHeight = 60
    }
    
    func configureLabel() {
    
    }
    
    func requestBoxOffice(text: String) {
        
        self.list.removeAll()

        let url = "\(EndPoint.boxOfficeURL)?key=\(APIKey.BOXOFFICE)&targetDt=\(text)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                                
                for movie in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
                    
                    let movieNm = movie["movieNm"].stringValue
                    let openDt = movie["openDt"].stringValue
                    let audiAcc = movie["audiAcc"].stringValue
                    let rank = movie["rnum"].stringValue
                    let rankInten = movie["rankInten"].stringValue
                    
                    let data = BoxOfficeModel(movieTitle: movieNm, releaseDate: openDt, totalCount: audiAcc, rank: rank, rankInten: rankInten)
                    
                    self.list.append(data)
                    
                }
            
                
                self.searchTableView.reloadData()
                print(self.list)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        format.dateFormat = "yyyy.MM.dd"
        let date = format.string(from: yesterday!)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseIdentifier, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        
        cell.backgroundColor = .clear
        
        if indexPath.row == list.count {
            cell.titleLabel.text = " 출처 : 영화진흥위원회 영화관 관람객 통합전산망 \n \(date) 업데이트"
            cell.titleLabel.numberOfLines = 0
            cell.titleLabel.font = .systemFont(ofSize: 12)
            cell.rankLabel.text = ""
        } else {
            cell.titleLabel.font = .boldSystemFont(ofSize: 22)
            cell.titleLabel.textAlignment = .left
            cell.titleLabel.text = "\(list[indexPath.row].rank).   \(list[indexPath.row].movieTitle)"
            cell.rankLabel.text = list[indexPath.row].rankInten
        }
        return cell
    }
    

}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        requestBoxOffice(text: searchBar.text!) //옵셔널 바인딩, 8글자, 숫자, 날짜로 변경 시 유효한 값인지 등
    }
}
