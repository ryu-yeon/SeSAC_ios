//
//  ImageSelectViewController.swift
//  Diary
//
//  Created by 유연탁 on 2022/08/21.
//

import UIKit

import JGProgressHUD
import Kingfisher

class ImageSelectViewController: BaseViewController {
    
    let mainView = ImageSelectView()
    let hud = JGProgressHUD()
    
    var imageList: [String] = []
    
    var selectIndexPath: IndexPath?
    
    var selectImage: UIImage?
    var delegate: SelectImageDelegate?
        
    var searchText: String = ""
    var startPage = 1
    var totalPage = 0
    
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
        mainView.collectionView.prefetchDataSource = self
        
    }
    
    @objc func selectButtonClicked() {
        
        guard let selectImage = selectImage else { return }
        
        delegate?.sendImageData(image: selectImage)
        navigationController?.popViewController(animated: true)
    }
    
    func requestImage(text: String, startPage: Int, totalPage: Int) {
        hud.show(in: self.view)
        UnsplashAPIManager.shared.requestImage(text: text, page: startPage) { imageList, totalPage in
            self.imageList.append(contentsOf: imageList)
            self.totalPage = totalPage
            DispatchQueue.main.async {
                self.mainView.collectionView.reloadData()
                self.hud.dismiss(animated: true)
            }
        }
    }
}

extension ImageSelectViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        
        let url = URL(string: imageList[indexPath.item])
        cell.imageView.kf.setImage(with: url)

        cell.layer.borderWidth = selectIndexPath == indexPath ? 4 : 0
        cell.layer.borderColor = selectIndexPath == indexPath ? UIColor.red.cgColor : nil
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        view.endEditing(true)
        selectIndexPath = indexPath
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell else { return }
        
        selectImage = cell.imageView.image
        
        collectionView.reloadData()
    }
    
}

extension ImageSelectViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if imageList.count - 1 == indexPath.item && startPage < totalPage {
                startPage += 1
                requestImage(text: self.searchText, startPage: startPage, totalPage: self.totalPage)
            }
        }
    }
    
}


extension ImageSelectViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.imageList.removeAll()
        self.searchText = searchBar.text ?? ""
        self.requestImage(text: searchText, startPage: startPage, totalPage: self.totalPage)
        if imageList.count < 15 {
            self.startPage += 1
            self.requestImage(text: searchText, startPage: startPage, totalPage: self.totalPage)
        }
        view.endEditing(true)
    }
}
