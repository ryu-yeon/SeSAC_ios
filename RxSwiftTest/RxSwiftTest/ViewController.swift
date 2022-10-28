//
//  ViewController.swift
//  RxSwiftTest
//
//  Created by 유연탁 on 2022/10/26.
//

import UIKit

import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
}
