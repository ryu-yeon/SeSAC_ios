//
//  BeerViewController.swift
//  SeSacNetwork
//
//  Created by 유연탁 on 2022/08/01.
//

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON

class BeerViewController: UIViewController {

    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var beerTextView: UITextView!
    @IBOutlet weak var beerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Random Beer"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .plain, target: self, action: #selector(randomBeerClicked))
        beerLabel.textAlignment = .center
        beerLabel.font = UIFont(name: "HSSantokki", size: 24)
        beerTextView.font = .systemFont(ofSize: 16)
        requestBeer()
    }
    
    
    @objc func randomBeerClicked() {
        requestBeer()
    }
    
    func requestBeer() {
        
        let url = "https://api.punkapi.com/v2/beers/random"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                self.beerLabel.text = json[0]["name"].stringValue
                self.beerTextView.text = json[0]["description"].stringValue
                let imageURL = URL(string: json[0]["image_url"].stringValue)
                self.beerImageView.kf.setImage(with: imageURL)
            case .failure(let error):
                print(error)
            }
        }
    }

}
