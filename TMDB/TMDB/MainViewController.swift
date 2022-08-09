//
//  MainViewController.swift
//  TMDB
//
//  Created by 유연탁 on 2022/08/09.
//

import UIKit

import Kingfisher

class MainViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!

    var movieList: [MovieModel] = []
    let titleList: [String] = ["Movie Trending", "TV Trending", "Person Trending", "All Treding"]
    override func viewDidLoad() {
        super.viewDidLoad()

        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: MainTableViewCell.reusableidentifier)
        
        view.backgroundColor = .black
//        listTableView.backgroundColor = .black
        requestData()
    }
    
    func requestData() {
        TMDBAPIMagnager.shared.requestTrendingData(startPage: 1) { movieList, totalcount in
            self.movieList.append(contentsOf: movieList)
            self.listTableView.reloadData()
        }
    }

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = listTableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reusableidentifier, for: indexPath) as! MainTableViewCell 
        
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
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCollectionViewCell.reusableidentifier, for: indexPath) as! ContentCollectionViewCell
        
        if collectionView.tag == 0 {
            let url = URL(string: "https://www.themoviedb.org/t/p/w1280/cXUqtadGsIcZDWUTrfnbDjAy8eN.jpg")
            cell.cardView.posterImageView.kf.setImage(with: url)
        } else if collectionView.tag == 1 {
            let url = URL(string: "https://www.themoviedb.org/t/p/w1280/stMXKaZYy5bhZII72F9yMl4AYxJ.jpg")
            cell.cardView.posterImageView.kf.setImage(with: url)
        } else {
            let url = URL(string: "https://www.themoviedb.org/t/p/w1280/mpOQpOKdo2XJnTqRzo1lTmDNsc1.jpg")
            cell.cardView.posterImageView.kf.setImage(with: url)
        }
        return cell
    }
    
}
