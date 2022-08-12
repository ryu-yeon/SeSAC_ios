//
//  ContentCollectionViewCell.swift
//  TMDB
//
//  Created by 유연탁 on 2022/08/09.
//

import UIKit

class ContentCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardView: CardView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.backgroundColor = .clear
        cardView.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cardView.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }
    
    
    @objc func likeButtonClicked() {
        print("클릭")
        if cardView.likeButton.currentImage == UIImage(systemName: "heart") {
            cardView.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else  {
            cardView.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }

}
