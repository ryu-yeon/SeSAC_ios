//
//  MainViewController.swift
//  TMDB
//
//  Created by 유연탁 on 2022/08/09.
//

import UIKit

import Kingfisher
import MapKit

class MainViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!

    var movieList: [String] = []
    var tvList: [String] = []
    var personList: [String] = []
    var allList: [String] = []
    
    let titleList: [String] = ["Movie Trending", "TV Trending", "Person Trending", "All Treding"]
    override func viewDidLoad() {
        super.viewDidLoad()

        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: MainTableViewCell.reusableidentifier)
        
        view.backgroundColor = .black
        requestData()
    }
    
    func requestData() {
        TMDBAPIMagnager.shared.requestPosterData(mediaType: "movie") { list in
            self.movieList.append(contentsOf: list)
            self.listTableView.reloadData()
        }
        TMDBAPIMagnager.shared.requestPosterData(mediaType: "tv") { list in
            self.tvList.append(contentsOf: list)
            self.listTableView.reloadData()
        }
        TMDBAPIMagnager.shared.requestPosterData(mediaType: "person") { list in
            self.personList.append(contentsOf: list)
            self.listTableView.reloadData()
        }
        TMDBAPIMagnager.shared.requestPosterData(mediaType: "all") { list in
            self.allList.append(contentsOf: list)
            self.listTableView.reloadData()
        }
    }

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reusableidentifier, for: indexPath) as! MainTableViewCell 
        
        cell.titleLabel.backgroundColor = .black
        cell.titleLabel.text = titleList[indexPath.section]
        cell.titleLabel.font = UIFont(name: "HSSantokki", size: 24)
        cell.titleLabel.textColor = .white
        
        cell.contentCollectionView.backgroundColor = .black
        cell.contentCollectionView.tag = indexPath.section
        cell.contentCollectionView.delegate = self
        cell.contentCollectionView.dataSource = self
        cell.contentCollectionView.register(UINib(nibName: "ContentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ContentCollectionViewCell.reusableidentifier)
        
        cell.contentCollectionView.reloadData()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 4
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return titleList.count
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView.tag {
        case 0: return movieList.count
        case 1: return movieList.count
        case 2: return movieList.count
        default: return movieList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCollectionViewCell.reusableidentifier, for: indexPath) as? ContentCollectionViewCell else {return UICollectionViewCell()}
        
        var url = URL(string: "")
        
        switch collectionView.tag {
        case 0: url = URL(string: EndPoint.posterBaseURL + movieList[indexPath.item])
        case 1: url = URL(string: EndPoint.posterBaseURL + tvList[indexPath.item])
        case 2:  url = URL(string: EndPoint.posterBaseURL + personList[indexPath.item])
        default: url = URL(string: EndPoint.posterBaseURL + allList[indexPath.item])
        }

        cell.cardView.posterImageView.kf.setImage(with: url)
        
        cell.cardView.likeButton.tintColor = .systemPink
        return cell
    }
    
}
