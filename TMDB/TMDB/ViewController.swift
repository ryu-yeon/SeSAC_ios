//
//  ViewController.swift
//  TMDB
//
//  Created by 유연탁 on 2022/08/03.
//

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
   
    var list: [MediaModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestTMDB()
        collectionView.dataSource = self
        collectionView.delegate = self
        setColletionViewLayout()
    }

    func requestTMDB() {
        let url = EndPoint.URL + "/movie/day?api_key=" + APIKey.TMDB
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("JSON: \(json)")
                
                for media in json["results"].arrayValue {
                    let title = media["title"].stringValue
                    let imageURL = media["backdrop_path"].stringValue
                    let overview = media["overview"].stringValue
                    let releaseDate = media["release_date"].stringValue
                    let genre = media["genre_ids"].arrayValue
                    
                    let data = MediaModel(title: title, imageURL: imageURL, overview: overview, releaseDate: releaseDate, genre: genre)
                    self.list.append(data)
                }
                
                self.collectionView.reloadData()

            case .failure(let error):
                print(error)
            }
        }
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reusableidentifier, for: indexPath) as! CollectionViewCell
        
        let url = URL(string: EndPoint.imageBaseURL + list[indexPath.item].imageURL)
        
        cell.imageView.kf.setImage(with: url)
        cell.titleLabel.text = list[indexPath.item].title
        cell.overviewLabel.text = list[indexPath.item].overview
        cell.dateLabel.text = list[indexPath.item].releaseDate
        
        let genreList = list[indexPath.item].genre

        var text = ""
        for genre in genreList {
            text += checkGenre(genre)
            text += " "
        }
        cell.genreLabel.text = text
        
        return cell
    }
    
    func setColletionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - spacing * 2
        let height = UIScreen.main.bounds.height - spacing * 2
        
        layout.itemSize = CGSize(width: width, height: height / 2.2)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .vertical
        
        collectionView.collectionViewLayout = layout
    }
    
    func checkGenre(_ genre: JSON) -> String {
        
        switch genre {
        case 16:
            return "#Animation"
        case 80:
            return "#Crime"
        case 18:
            return "#Drama"
        case 28:
            return "#Action"
        case 35:
            return "#Comedy"
        case 9648:
            return "#Mystery"
        case 14:
            return "#Fantasy"
        case 12:
            return "#Adventure"
        case 53:
            return "#Thriller"
        default:
            return ""
  
        }
    }
}
