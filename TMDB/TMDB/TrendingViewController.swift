//
//  TrendingViewController.swift
//  TMDB
//
//  Created by 유연탁 on 2022/08/03.
//

import UIKit

import JGProgressHUD
import Kingfisher

class TrendingViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
   
    let hud = JGProgressHUD()
    
    var list: [MovieModel] = []
    var castList: [CastModel] = []
    
    var startPage = 1
    var totalCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "MOVIE"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "location.magnifyingglass"), style: .plain, target: self, action: #selector(goToMap))
        navigationItem.backButtonTitle = " "
        
        requestTrending(startPage: startPage)
        
        collectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: MovieCollectionViewCell.reusableidentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.prefetchDataSource = self
        setColletionViewLayout()
    }

    func requestTrending(startPage: Int) {
        
        hud.show(in: self.view)
        TMDBAPIMagnager.shared.requestTrendingData(startPage: startPage) { list, totalCount in
            self.list.append(contentsOf: list)
            self.totalCount = totalCount
            for number in 0..<list.count {
                TMDBAPIMagnager.shared.requestMovieData(movieId: list[number].id) { castList in
                    self.castList.append(contentsOf: castList)
                    
                    DispatchQueue.main.async {
                        if self.castList.count == self.list.count {
                            self.collectionView.reloadData()
                            self.hud.dismiss(animated: true)
                        }
                    }
                }
            }
        }
    }
    
    @objc func goToMap() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: MapViewController.reusableidentifier) as! MapViewController
        
        navigationController?.pushViewController(vc, animated: true)
        
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

                requestTrending(startPage: startPage)
            }
        }
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

