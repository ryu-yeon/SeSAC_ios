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
    var thumnailList: [String] = []
    
    var selectIndexPath: IndexPath?
    
    var selectImage: UIImage?
    var delegate: SelectImageDelegate?
    
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
        
        guard let selectImage = selectImage else { return }
        
        delegate?.sendImageData(image: selectImage)
        navigationController?.popViewController(animated: true)
    }
}

extension ImageSelectViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        
        let url = URL(string: thumnailList[indexPath.item])
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

extension ImageSelectViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        UnsplashAPIManager.shared.requestImage(searchBar.text ?? "") { imageList, thumnailList in
            self.imageList.append(contentsOf: imageList)
            self.thumnailList.append(contentsOf: thumnailList)
            DispatchQueue.main.async {
                self.mainView.collectionView.reloadData()
            }
        }
        view.endEditing(true)
    }
}
