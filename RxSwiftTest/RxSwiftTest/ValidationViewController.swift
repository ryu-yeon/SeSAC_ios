//
//  ValidationViewController.swift
//  RxSwiftTest
//
//  Created by 유연탁 on 2022/10/27.
//

import UIKit

import RxCocoa
import RxSwift

class ValidationViewController: UIViewController {

    @IBOutlet weak var validationLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var stepButton: UIButton!
    
    let viewModel = ValidationViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
//        observableVSSubject()
    }

    func bind() {
        
//        let input = ValidationViewModel.Input(text: nameTextField.rx.text, tap: stepButton.rx.tap)
//        let output = viewModel.transform(input: input)
        
//        output.validaion
        
        viewModel.validText
            .asDriver()
            .drive(validationLabel.rx.text)
            .disposed(by: disposeBag)
        
        let validation = nameTextField.rx.text
            .orEmpty
            .map { $0.count >= 8}
            .share() //Subject, Relay

        validation
            .bind(to: stepButton.rx.isEnabled, validationLabel.rx.isHidden)
            .disposed(by: disposeBag)

        validation
            .withUnretained(self)
            .bind { (vc, value) in
                let color: UIColor = value ? .systemPink : .lightGray
                vc.stepButton.backgroundColor = color
            }
            .disposed(by: disposeBag)
        

        
        stepButton.rx.tap
            .subscribe { _ in
                print("next")
            } onError: { error in
                print("error")
            } onCompleted: {
                print("complete")
            } onDisposed: {
                print("dispose")
            }
            .disposed(by: disposeBag)
        //.disposed(by: DisposeBag()) //?? dispose 리소스 정리, deinit

    }
    
    func observableVSSubject() {
        
        let testA = stepButton.rx.tap
            .map { "안녕하세요 "}
//            .share()
            .asDriver(onErrorJustReturn: "")

        
        testA
            .drive(validationLabel.rx.text)
            .disposed(by: disposeBag)
       
        testA
            .drive(nameTextField.rx.text)
            .disposed(by: disposeBag)
    
        testA
            .drive(stepButton.rx.title())
            .disposed(by: disposeBag)
        
        let sampleInt = Observable<Int>.create { observer in
            observer.onNext(Int.random(in: 1...100))
            return Disposables.create()
        }
        
        sampleInt.subscribe { value in
            print("sampleInt: \(value)")
        }
        .disposed(by: disposeBag)
        
        sampleInt.subscribe { value in
            print("sampleInt: \(value)")
        }
        .disposed(by: disposeBag)
        
        sampleInt.subscribe { value in
            print("sampleInt: \(value)")
        }
        .disposed(by: disposeBag)
        
        let subjectInt = BehaviorSubject(value: 0)
        subjectInt.onNext(Int.random(in: 1...100))
        
        subjectInt.subscribe { value in
            print("subjectInt: \(value)")
        }
        .disposed(by: disposeBag)
        
        subjectInt.subscribe { value in
            print("subjectInt: \(value)")
        }
        .disposed(by: disposeBag)
        
        subjectInt.subscribe { value in
            print("subjectInt: \(value)")
        }
        .disposed(by: disposeBag)
    }
}
