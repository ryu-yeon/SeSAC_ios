//
//  CardCollectionViewCell.swift
//  SeSacWeek6
//
//  Created by 유연탁 on 2022/08/09.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cardView: CardView!
    
    //변경되지 않는 UI
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        print("CardCollectionViewCell", #function)

        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        cardView.contentLabel.text = nil
    }
    
    
    
    func setupUI() {
        cardView.backgroundColor = .clear
        cardView.posterImageView.backgroundColor = .lightGray
        cardView.posterImageView.layer.cornerRadius = 10
        cardView.likeButton.tintColor = .systemPink
        
    }

}
