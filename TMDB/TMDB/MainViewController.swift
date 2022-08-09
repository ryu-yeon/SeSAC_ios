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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: MainTableViewCell.reusableidentifier)
    }

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = listTableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reusableidentifier, for: indexPath) as! MainTableViewCell 
        
        cell.contentCollectionView.delegate = self
        cell.contentCollectionView.dataSource = self
        cell.contentCollectionView.register(UINib(nibName: "ContentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ContentCollectionViewCell.reusableidentifier)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 4
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCollectionViewCell.reusableidentifier, for: indexPath) as! ContentCollectionViewCell
        
        
        let url = URL(string: "https://www.themoviedb.org/t/p/w1280/oMa5NjFxK8Csp6uVQ0tRuF1pWM5.jpg")
        cell.cardView.posterImageView.kf.setImage(with: url)
        
        return cell
    }
    
}
