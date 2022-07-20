//
//  SearchTableViewController.swift
//  TrendMedia
//
//  Created by 유연탁 on 2022/07/20.
//

import UIKit

class SearchTableViewController: UITableViewController {

    var moviewList = MovieInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
      

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviewList.movie.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        
        let data = moviewList.movie[indexPath.row]
        
        cell.configureCell(data: data)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 8
    }
}
