//
//  MovieViewController.swift
//  TMDB
//
//  Created by 유연탁 on 2022/08/05.
//

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON

class MovieViewController: UIViewController {

    var movie: MovieModel?
    var castList: CastModel?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var castTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "출연/제작"
        
        let url = URL(string: EndPoint.imageBaseURL + (movie?.imageURL ?? ""))
        movieImageView.kf.setImage(with: url)
        
        nameLabel.text = movie?.title
        nameLabel.textColor = .white
        nameLabel.font = .systemFont(ofSize: 24, weight: .bold)
        
        
        let posterURL = URL(string: EndPoint.posterBaseURL + (movie?.posterURL ?? ""))
        posterImageView.kf.setImage(with: posterURL)
        overviewTextView.text = movie?.overview
        overviewTextView.isEditable = false
        overviewTextView.font = .systemFont(ofSize: 14)
        
        castTableView.register(UINib(nibName: "CastTableViewCell", bundle: nil), forCellReuseIdentifier: CastTableViewCell.reusableidentifier)
        
        castTableView.delegate = self
        castTableView.dataSource = self
    }
}

extension MovieViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return castList?.casts.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = castTableView.dequeueReusableCell(withIdentifier: CastTableViewCell.reusableidentifier, for: indexPath) as! CastTableViewCell
        

        let url = URL(string: EndPoint.profileBaseURL + (castList?.imageURL[indexPath.row] ?? ""))
        cell.profileImageView.kf.setImage(with: url)
        cell.profileImageView.layer.cornerRadius = 8
        cell.nameLabel.text = castList?.casts[indexPath.row]
        cell.nameLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        cell.characterLabel.text = castList?.characters[indexPath.row]
        cell.characterLabel.textColor = .gray
        cell.characterLabel.font = .systemFont(ofSize: 16, weight: .regular)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
