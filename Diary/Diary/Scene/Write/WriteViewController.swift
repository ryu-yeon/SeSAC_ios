//
//  WriteViewController.swift
//  Diary
//
//  Created by 유연탁 on 2022/08/21.
//

import UIKit

import RealmSwift

protocol SelectImageDelegate {
    func sendImageData(image: UIImage)
}

class WriteViewController: BaseViewController {
    
    let mainView = WriteView()
    
    let localRealm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        self.mainView.addImageButton.layer.cornerRadius = self.mainView.addImageButton.bounds.height / 2
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func configure() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
        mainView.addImageButton.addTarget(self, action: #selector(addImageButtonClicked), for: .touchUpInside)
        
    }
    
    @objc func closeButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func saveButtonClicked() {
        
        let task = UserDiary(diaryTitle: mainView.titleTextField.text!, subTitle: mainView.subTitleTextField.text, diaryContenet: mainView.userTextView.text, diaryDate: Date(), registerDate: Date(), favorite: false)
        
        do {
            try! localRealm.write {
                localRealm.add(task)
            }
        } catch let error{
            print(error)
        }
        
        if let image = mainView.userImageView.image {
            saveImageToDocument(fileName: "\(task.objectId).jpg", image: image)
            print("Realm Succeed")
        } else {
            print("이미지 없음")
        }
        dismiss(animated: true)
    }
    
    @objc func addImageButtonClicked() {
        let vc = ImageSelectViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension WriteViewController: SelectImageDelegate {
    func sendImageData(image: UIImage) {
        mainView.userImageView.image = image
    }
    
}
