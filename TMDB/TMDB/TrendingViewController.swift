//
//  TrendingViewController.swift
//  TMDB
//
//  Created by 유연탁 on 2022/08/03.
//

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON

class TrendingViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
   
    var list: [MovieModel] = []
    var castList: [CastModel] = []
    
    var startPage = 1
    var totalCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "MOVIE"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: nil)
        navigationItem.backButtonTitle = " "
        
        requestTrending(page: startPage)
        
        collectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: MovieCollectionViewCell.reusableidentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.prefetchDataSource = self
        setColletionViewLayout()
        
    }
    

    func requestTrending(page: Int) {
        let url = EndPoint.TrendURL + "/movie/day?api_key=" + APIKey.TMDB + "&page=\(page)"
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
                    let genre = media["genre_ids"].arrayValue.map {$0.intValue}
                    let id = media["id"].intValue
                    let posterURL = media["poster_path"].stringValue

//                    self.movieList.append(id)
                    
                    let data = MovieModel(id: id, posterURL: posterURL, title: title, imageURL: imageURL, overview: overview, releaseDate: releaseDate, genre: genre)
                    self.list.append(data)
                }
                
                for number in (20 * (startPage - 1))..<(20 * startPage) {
                    self.requestMovie(movieId: list[number].id)
                }
                self.totalCount = json["total_pages"].intValue

            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestMovie(movieId: Int) {
        let url = EndPoint.MovieURL + "/\(movieId)/credits?api_key=" + APIKey.TMDB + "&language=en-US"
        AF.request(url, method: .get).validate().responseData { [self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)

                var casts: [String] = []
                var characters: [String] = []
                var imageURL: [String] = []
                
                for person in json["cast"].arrayValue {
                    casts.append(person["name"].stringValue)
                    characters.append(person["character"].stringValue)
                    imageURL.append(person["profile_path"].stringValue)
                }
                
                let data = CastModel(casts: casts, characters: characters, imageURL: imageURL)
                self.castList.append(data)
                
                if self.castList.count == self.list.count {
                    collectionView.reloadData()
                }
                
                
            case .failure(let error):
                print(error)
            }
        }

    }
}

extension TrendingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.reusableidentifier, for: indexPath) as! MovieCollectionViewCell
        
        let url = URL(string: EndPoint.imageBaseURL + list[indexPath.item].imageURL)
        
        cell.imageView.kf.setImage(with: url)
        cell.titleLabel.text = list[indexPath.item].title
        cell.titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        var casts = ""
        
        for cast in castList[indexPath.item].casts {
            casts += "\(cast)"
            if cast == castList[indexPath.item].casts.last {
                break
            }
            casts += ", "
        }
        
        cell.castLabel.text = casts
        cell.castLabel.font = .systemFont(ofSize: 12, weight: .regular)
        cell.castLabel.textColor = .gray
        cell.dateLabel.text = list[indexPath.item].releaseDate
        cell.dateLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        cell.dateLabel.textColor = .gray
        
        let genreList = list[indexPath.item].genre

        var text = ""
        for genre in genreList {
            text += "#\(Genre.genre[genre] ?? "")"
            if genre == genreList.last {
                break
            }
            text += " "
        }
        
        cell.genreLabel.text = text
        cell.genreLabel.font = UIFont(name: "HSSantokki", size: 20)
        
        cell.mediaView.layer.cornerRadius = 20
        cell.mediaView.layer.shadowColor = UIColor.gray.cgColor
        cell.mediaView.layer.shadowOpacity = 1
        cell.mediaView.layer.shadowRadius = 10
        
        cell.index = indexPath.item
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: MovieViewController.reusableidentifier) as! MovieViewController
       
        vc.movie = list[indexPath.item]
        vc.castList = castList[indexPath.item]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setColletionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - spacing * 2
        
        layout.itemSize = CGSize(width: width, height: width)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .vertical
        
        collectionView.collectionViewLayout = layout
    }
    
}

extension TrendingViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        for indexPath in indexPaths {
            if list.count - 1 == indexPath.item && startPage < totalCount{
                startPage += 1

                requestTrending(page: startPage)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print("====취소:\(indexPaths)")
    }
    
}

extension TrendingViewController: ComponentProductCellDelegate {
    func selectedInfoBtn(index: Int) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: WebViewController.reusableidentifier) as! WebViewController
        vc.movieTitle = list[index].title
        vc.movieId = list[index].id
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

