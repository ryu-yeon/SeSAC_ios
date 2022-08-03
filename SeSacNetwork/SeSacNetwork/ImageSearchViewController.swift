//
//  ImageSearchViewController.swift
//  SeSacNetwork
//
//  Created by 유연탁 on 2022/08/03.
//

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON

class ImageSearchViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var list: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        fetchImage()
        collectionViewLayout()
    }
    
    //fetchImage, requestImage, callREquestImage, getImage...
    func fetchImage() {
        
        
        let text = "과자".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = EndPoint.imageSearchURL+"query=\(text)&display=30&start=1&sort=sim"
        
        let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_ID, "X-Naver-Client-Secret": APIKey.NAVER_SECRET]
        
        AF.request(url, method: .get, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                for image in json["items"].arrayValue {
                    
                    self.list.append(image["link"].stringValue)
                }
                
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension ImageSearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageSearchCollectionViewCell.reuseIdentifier, for: indexPath) as! ImageSearchCollectionViewCell
        let url = URL(string: list[indexPath.item])
        cell.imageView.kf.setImage(with: url)
        
        return cell
    }
    
    func collectionViewLayout() {
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - spacing * 2
        
        layout.itemSize = CGSize(width: width, height: width * 1.5)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .vertical
        
        collectionView.collectionViewLayout = layout
    }
    
    
}
