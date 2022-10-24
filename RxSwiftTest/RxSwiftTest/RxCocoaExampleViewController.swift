//
//  RxCocoaExampleViewController.swift
//  RxSwiftTest
//
//  Created by 유연탁 on 2022/10/24.
//

import UIKit

import RxCocoa
import RxSwift

class RxCocoaExampleViewController: UIViewController {

    @IBOutlet weak var simpleSwitch: UISwitch!
    @IBOutlet weak var simplePickerView: UIPickerView!
    @IBOutlet weak var simpleTableView: UITableView!
    @IBOutlet weak var simpleLabel: UILabel!
    
    @IBOutlet weak var signName: UITextField!
    @IBOutlet weak var signEmail: UITextField!
    
    @IBOutlet weak var simpleButton: UIButton!
    
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
        setPickerView()
        setSwitch()
        setSign()
        setOperator()
    }


    
    func setTableView() {
        
        simpleTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let items = Observable.just([
            "First Item",
            "Second Item",
            "Third Item"
        ])

        items
        .bind(to: simpleTableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(element) @ row \(row)"
            return cell
        }
        .disposed(by: disposeBag)
        
        simpleTableView.rx.modelSelected(String.self)
            .map { data in
                "\(data)를 클릭했습니다."
            }
            .bind(to: simpleLabel.rx.text)
            .disposed(by: disposeBag)

    }
    
    func setPickerView() {
        let items = Observable.just([
                "영화",
                "드라마",
                "애니메이션",
                "기타"
            ])
     
        items
            .bind(to: simplePickerView.rx.itemTitles) { (row, element) in
                return element
            }
            .disposed(by: disposeBag)
        
        simplePickerView.rx.modelSelected(String.self)
            .map {$0.first}
            .bind(to: simpleLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    func setSwitch() {
        Observable.of(false)
            .bind(to: simpleSwitch.rx.isOn)
            .disposed(by: disposeBag)
        
    }
    
    func setOperator() {
        let itemsA = [3.3, 4.0, 5.0, 2.0, 3.6, 4.8]
        let itemsB = [2.3, 2.0, 1.3]
        
        Observable.just(itemsA)
            .subscribe { value in
                print("just - \(value)")
            } onError: { error in
                print("just - \(error)")
            } onCompleted: {
                print("just - completed")
            } onDisposed: {
                print("just - disposed")
            }
            .disposed(by: disposeBag)
        
        Observable.of(itemsA, itemsB)
            .subscribe { value in
                print("of - \(value)")
            } onError: { error in
                print("of - \(error)")
            } onCompleted: {
                print("of - completed")
            } onDisposed: {
                print("of - disposed")
            }
            .disposed(by: disposeBag)
        
        Observable.from(itemsA)
            .subscribe { value in
                print("from - \(value)")
            } onError: { error in
                print("from - \(error)")
            } onCompleted: {
                print("from - completed")
            } onDisposed: {
                print("from - disposed")
            }
            .disposed(by: disposeBag)

    }
    
    func setSign() {
        //ex. 텍스트필드1(Observable), 텍스트필드2(Observable) > 레이블(Observer, bind)
        Observable.combineLatest(signName.rx.text.orEmpty, signEmail.rx.text.orEmpty) { value1, value2 in
            return "name은 \(value1)이고, 이메일은 \(value2)입니다."
        }
        .bind(to: simpleLabel.rx.text)
        .disposed(by: disposeBag)
        
        signName.rx.text.orEmpty
            .map { $0.count < 5 }
            .bind(to: signEmail.rx.isHidden)
            .disposed(by: disposeBag)
        
        signEmail.rx.text.orEmpty
            .map { $0.count > 5}
            .bind(to: simpleButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        simpleButton.rx.tap
            .subscribe { _ in
                self.showAlert()
            }
            .disposed(by: disposeBag)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "하하하", message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(ok)
        present(alert, animated: true)
    }
}

