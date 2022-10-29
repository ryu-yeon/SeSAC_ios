//
//  WriteViewController.swift
//  Memo
//
//  Created by 유연탁 on 2022/08/31.
//

import UIKit

import RxCocoa
import RxSwift

class WriteViewController: BaseViewController {
    
    private let mainView = WriteView()
    let viewModel = WriteViewModel()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setNavigationBarButton()
        
        mainView.userTextView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        viewModel.writeMemo(memoText: mainView.userTextView.text)
    }
    
    private func bind() {
        viewModel.list
            .bind { value in
                if value.content != nil {
                    self.mainView.userTextView.text = value.title + "\n" + value.content!
                } else {
                    self.mainView.userTextView.text = value.title
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.fetch()
    }
    
    private func setNavigationBarButton() {
        let sharedButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"))
        let saveButton = UIBarButtonItem(title: "완료")
        
        sharedButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                guard let sharedText = vc.mainView.userTextView.text else { return }
                
                let acitivityVC = UIActivityViewController(activityItems: [sharedText], applicationActivities: [])
                vc.present(acitivityVC, animated: true)
            }
            .disposed(by: disposeBag)
        
        saveButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
        
        navigationItem.rightBarButtonItems = [saveButton, sharedButton]
    }
}
