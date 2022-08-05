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

    var movie: MediaModel?
    var movieId: Int?
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var castTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = movie?.title
        let url = URL(string: EndPoint.imageBaseURL + (movie?.imageURL ?? ""))
        movieImageView.kf.setImage(with: url)
        overViewLabel.text = movie?.overview
        
        castTableView.register(UINib(nibName: "CastTableViewCell", bundle: nil), forCellReuseIdentifier: CastTableViewCell.reusableidentifier)
        
        castTableView.delegate = self
        castTableView.dataSource = self
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
                

            case .failure(let error):
                print(error)
            }
        }

    }
    
    
    
    
}

extension MovieViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = castTableView.dequeueReusableCell(withIdentifier: CastTableViewCell.reusableidentifier, for: indexPath) as! CastTableViewCell
//        cell.castImageView.image =
//        cell.castNameLabel.text =
//        cell.castNicknameLabel =
        
        return cell
    }
    
    
}
