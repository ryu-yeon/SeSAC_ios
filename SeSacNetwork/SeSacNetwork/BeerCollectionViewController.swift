//
//  BeerCollectionViewController.swift
//  SeSacNetwork
//
//  Created by 유연탁 on 2022/08/03.
//

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON

class BeerCollectionViewController: UICollectionViewController {

    var list: [Beer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - spacing * 3
        
        layout.itemSize = CGSize(width: width / 2, height: width / 2 * 1.5)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .vertical 
        
        collectionView.collectionViewLayout = layout
        
        requestBeer()
    }
    
    
    func requestBeer() {
        let url = EndPoint.beerURL
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                for beer in json.arrayValue {
                    let name = beer["name"].stringValue
                    let imageURL = beer["image_url"].stringValue
                    let description = beer["description"].stringValue
                    
                    let data = Beer(name: name, imageURL: imageURL, description: description)
                    
                    self.list.append(data)
                }
                self.collectionView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BeerCollectionViewCell.reuseIdentifier, for: indexPath) as! BeerCollectionViewCell
        
        cell.backgroundColor = .lightGray
        cell.layer.cornerRadius = 10
        cell.nameLabel.text = list[indexPath.item].name
        cell.nameLabel.font = UIFont(name: "HSSantokki", size: 18)
        cell.descriptionTextView.text = list[indexPath.item].description
        cell.descriptionTextView.font = .systemFont(ofSize: 12)
        cell.descriptionTextView.backgroundColor = .clear
        let url = URL(string: list[indexPath.item].imageURL)
        cell.beerImageView.kf.setImage(with: url)
        return cell
    }
    
}
