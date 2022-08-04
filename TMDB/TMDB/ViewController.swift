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
    var movieList: [Int] = []
    var castList: [[String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "MOVIE"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: nil)
        
        requestTrending()
        collectionView.dataSource = self
        collectionView.delegate = self
        setColletionViewLayout()
        
    }

    func requestTrending() {
        let url = EndPoint.TrendURL + "/movie/day?api_key=" + APIKey.TMDB
        AF.request(url, method: .get).validate().responseData { [self] response in
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
                    
                    self.movieList.append(media["id"].intValue)
//                    requestMovie(movieId: media["id"].intValue)
                    let data = MediaModel(title: title, imageURL: imageURL, overview: overview, releaseDate: releaseDate, genre: genre)
                    self.list.append(data)
                }
                for movie in movieList {
                    self.requestMovie(movieId: movie)
                }
                print(castList)
                collectionView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestMovie(movieId: Int) {
        let url = EndPoint.MovieURL + "/\(movieId)/credits?api_key=" + APIKey.TMDB + "&language=en-US"
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)

                var casts: [String] = []
                
                for person in json["cast"].arrayValue {
                    casts.append(person["name"].stringValue)
                }
                self.castList.append(casts)

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
        cell.titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
//        var casts = ""
//
//        for cast in castList[indexPath.item] {
//            casts += "\(cast), "
//        }
//        print(castList[indexPath.item])

//        cell.overviewLabel.text = casts
        cell.overviewLabel.font = .systemFont(ofSize: 12, weight: .regular)
        cell.overviewLabel.textColor = .gray
        cell.dateLabel.text = list[indexPath.item].releaseDate
        cell.dateLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        cell.dateLabel.textColor = .gray
        
        let genreList = list[indexPath.item].genre

        var text = ""
        for genre in genreList {
            text += checkGenre(genre)
            text += " "
        }
        cell.genreLabel.text = text
        cell.genreLabel.font = UIFont(name: "HSSantokki", size: 20)
        
        cell.mediaView.layer.cornerRadius = 20
        cell.mediaView.layer.shadowColor = UIColor.gray.cgColor
        cell.mediaView.layer.shadowOpacity = 1
        cell.mediaView.layer.shadowRadius = 10
        
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
        case 10751:
            return "#Family"
        case 878:
            return "#Science Fiction"
        case 10749:
            return "#Romance"
        default:
            return ""
  
        }
    }
}
