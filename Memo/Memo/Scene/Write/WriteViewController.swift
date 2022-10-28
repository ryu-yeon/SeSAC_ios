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
        
        let sharedButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(sharedButtonClicked))
        let saveButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(saveButtonClicked))
        navigationItem.rightBarButtonItems = [saveButton, sharedButton]
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
    
    @objc func saveButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func sharedButtonClicked() {
        
        guard let sharedText = mainView.userTextView.text else { return }
        
        let vc = UIActivityViewController(activityItems: [sharedText], applicationActivities: [])
        present(vc, animated: true)
    }
}
