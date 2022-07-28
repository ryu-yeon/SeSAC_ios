//
//  WebViewController.swift
//  SeSacNetwork
//
//  Created by 유연탁 on 2022/07/28.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var webView: WKWebView!
    
    var destionationURL: String = "https://www.apple.com"
    //App Transport Scurity Settings
    //http X
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        openWebPage(url: destionationURL)
        
    }
    
    func openWebPage(url: String) {
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }

}

extension WebViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        openWebPage(url: searchBar.text!)
    }
}
