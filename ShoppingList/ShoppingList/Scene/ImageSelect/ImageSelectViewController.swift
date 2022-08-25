//
//  ImageSelectViewController.swift
//  ShoppingList
//
//  Created by 유연탁 on 2022/08/25.
//

import UIKit

import Kingfisher

class ImageSelectViewController: BaseViewController {

    let mainView = ImageSelectView()
    
    var imageList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func configure() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.register(ImageSelctCollectionViewCell.self, forCellWithReuseIdentifier: ImageSelctCollectionViewCell.reuableIdentifier)
        
        mainView.userSearchBar.delegate = self
    }
}

extension ImageSelectViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageSelctCollectionViewCell.reuableIdentifier, for: indexPath) as? ImageSelctCollectionViewCell else { return UICollectionViewCell() }
        let url = URL(string: imageList[indexPath.row])
        cell.itemImageView.kf.setImage(with: url)
        return cell
    }
}

extension ImageSelectViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        UnsplashAPIManager.shared.requestImage(text) { imageList in
            self.imageList.append(contentsOf: imageList)
            
            DispatchQueue.main.async {
                self.mainView.collectionView.reloadData()
            }
        }
    }
}
