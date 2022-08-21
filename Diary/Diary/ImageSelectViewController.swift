//
//  ImageSelectViewController.swift
//  Diary
//
//  Created by 유연탁 on 2022/08/21.
//

import UIKit

import Kingfisher

class ImageSelectViewController: BaseViewController {
    
    let mainView = ImageSelectView()
    
    var imageList: [String] = []
    var num: Int?
    
    var selectedImageURL: String?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func configure() {
        navigationItem.title = "사진"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(selectButtonClicked))
        
        mainView.collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCollectionViewCell")
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
        mainView.searchBar.delegate = self
        
    }
    
    @objc func selectButtonClicked() {
        
        dismiss(animated: true)
    }
}

extension ImageSelectViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        
        let url = URL(string: imageList[indexPath.item])
        cell.imageView.kf.setImage(with: url)
        
        if let selectCell = num {
            if indexPath.item == selectCell {
            cell.layer.borderWidth = 2
            cell.layer.borderColor = UIColor.blue.cgColor
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        view.endEditing(true)
        num = indexPath.item
        selectedImageURL = imageList[indexPath.item]
        collectionView.reloadData()
    }
}

extension ImageSelectViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        APIManager.shared.requestImage(searchBar.text ?? "") { imageList in
            self.imageList.append(contentsOf: imageList)
            
            DispatchQueue.main.async {
                self.mainView.collectionView.reloadData()
            }
        }
        view.endEditing(true)
    }
}
