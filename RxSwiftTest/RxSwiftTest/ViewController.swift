//
//  ViewController.swift
//  RxSwiftTest
//
//  Created by 유연탁 on 2022/10/26.
//

import UIKit

import RxSwift
import RxCocoa
import RxAlamofire
import RxDataSources

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    lazy var dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Int>>(configureCell: { textRxDataSource, tableView, indexPath, item in
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "\(item)"
        return cell
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Observable.of(1,2,3,4,5,6,7,8,9,10)
            .skip(3)
            .filter { $0 % 2 == 0 }
            .map { $0 * 2 }
            .subscribe { value in
                print("=== \(value)")
            }
            .disposed(by: disposeBag)
        
        testAlamofire()
        textRxDataSource()
        
        button.rx.tap
            .withUnretained(self)
            .subscribe { (vc, _) in
                self.label.text = "안녕 반가워"
            }
            .disposed(by: disposeBag)
        
        //Operator로 데이터 stream 조작
        button.rx.tap
            .map { "안녕 반가워"}
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
        
        //driver traits: bind + stream 공유(리소스 방지, share() )
        button.rx.tap
            .map { "안녕 반가워" }
            .asDriver(onErrorJustReturn: "")
            .drive(label.rx.text)
            .disposed(by: disposeBag)
    }
    
    func testAlamofire() {
        let url = APIKey.searchURL + "apple"
        
        request(.get, url, headers: ["Authorization": APIKey.authorization])
            .data()
            .decode(type: SearchPhoto.self, decoder: JSONDecoder())
            .subscribe(onNext: { vlaue in
                print(vlaue.results[0].likes)
            })
            .disposed(by: disposeBag)
    }
    
    func textRxDataSource() {
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource[index].model
        }
        
        Observable.just([
            SectionModel(model: "title1", items: [1, 2, 3]),
            SectionModel(model: "title2", items: [4, 5, 6]),
            SectionModel(model: "title3", items: [7, 8, 9])
        ])
        .bind(to: tableView.rx.items(dataSource: dataSource))
        .disposed(by: disposeBag)
    }
}
