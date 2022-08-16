//
//  WebViewController.swift
//  TMDB
//
//  Created by 유연탁 on 2022/08/06.
//

import UIKit
import WebKit

import Alamofire
import SwiftyJSON

class WebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    var movieTitle: String?
    var movieId: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = movieTitle ?? ""
        requestURL()
        
    }

    private func openWebPage(urlStr: String) {
        guard let url = URL(string: urlStr) else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    private func requestURL() {
        let url = EndPoint.MovieURL + "/\(movieId ?? 0)/videos?api_key=" + APIKey.TMDB + "&language=en-US"
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let urlStr = EndPoint.youtubeBaseURL + json["results"][0]["key"].stringValue
                self.openWebPage(urlStr: urlStr)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
