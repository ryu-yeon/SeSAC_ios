//
//  ItemViewController.swift
//  ShoppingList
//
//  Created by 유연탁 on 2022/08/24.
//

import UIKit

import RealmSwift

protocol SelectImageDelegate {
    func sendImageData(image: UIImage)
}

class ItemViewController: BaseViewController {
    
    let mainView = ItemView()
    
    let localRealm = try! Realm()
    
    var task: ShoppingList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillLayoutSubviews() {
        self.mainView.addImageButton.layer.cornerRadius = mainView.addImageButton.bounds.height / 2
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        try! localRealm.write {
            task.detailText = mainView.detailTextView.text
        }
        if let image = mainView.itemImageView.image {
        saveImageToDocument(fileName: "\(task.ObjectId).jpg", image: image)
        }
    }
    
    override func configure() {
        
        mainView.itemLable.text = task?.shoppingItem
        
        mainView.itemImageView.image = loadImageFromDocument(fileName: "\(task.ObjectId).jpg")
        
        let format = DateFormatter()
        
        format.dateFormat = "yyyy.MM.dd hh:mm"
        
        mainView.dateLabel.text = format.string(from: task.registerDate)
        
        mainView.detailTextView.text = task.detailText
        
        setCheckImage()
        setFavoriteImage()
        
        mainView.addImageButton.addTarget(self, action: #selector(addImageButtonClicked), for: .touchUpInside)
        
        mainView.checkButton.addTarget(self, action: #selector(checkButtonClicked), for: .touchUpInside)
        mainView.favoriteButton.addTarget(self, action: #selector(favoriteButtonClicked), for: .touchUpInside)
    }
    
    @objc func addImageButtonClicked() {
        let vc = ImageSelectViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func checkButtonClicked() {
        try! localRealm.write {
            task.checkItem = !task.checkItem
        }
        setCheckImage()
    }
    
    @objc func favoriteButtonClicked() {
        
        try! localRealm.write {
            task.favoriteItem = !task.favoriteItem
        }
        setFavoriteImage()
    }
    
    func setCheckImage() {
        let checkImage = task.checkItem ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "checkmark.square")
        mainView.checkButton.setImage(checkImage, for: .normal)
    }
    
    func setFavoriteImage() {
        let favoriteImage = task.favoriteItem ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        
        mainView.favoriteButton.setImage(favoriteImage, for: .normal)
    }
}

extension ItemViewController: SelectImageDelegate {
    func sendImageData(image: UIImage) {
        mainView.itemImageView.image = image
    }
}
