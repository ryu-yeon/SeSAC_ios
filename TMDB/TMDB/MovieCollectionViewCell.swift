//
//  MovieCollectionViewCell.swift
//  TMDB
//
//  Created by 유연탁 on 2022/08/03.
//

import UIKit

protocol ComponentProductCellDelegate {
    func selectedInfoBtn(index: Int)
}

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var castLabel: UILabel!
    @IBOutlet weak var mediaView: UIView!

    var index: Int?
    var delegate: ComponentProductCellDelegate?
    
    @IBAction func movieButtonClicked(_ sender: UIButton) {
//        self.delegate?.selectedInfoBtn(index: index ?? 0)
        // 트랜딩 뷰 컨트롤러에 인덱스
        delegate?.selectedInfoBtn(index: index ?? 0)
    }
    
}

