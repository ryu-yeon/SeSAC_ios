//
//  SearchTableViewCell.swift
//  TrendMedia
//
//  Created by 유연탁 on 2022/07/20.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var summaryLabel: UILabel!
    
    func configureCell(data: Movie) {
        movieImageView.image = UIImage(named: "\(data.title)")
        titleLabel.text = data.title
        titleLabel.font = .boldSystemFont(ofSize: 17)
        dateLabel.text = "\(data.releaseDate) | \(data.runtime) | \(data.rate)"
        dateLabel.font = .systemFont(ofSize: 10)
        summaryLabel.text = data.overview
        summaryLabel.font = .systemFont(ofSize: 11)
    }
    

}
