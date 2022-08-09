//
//  MainTableViewCell.swift
//  TMDB
//
//  Created by 유연탁 on 2022/08/09.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .black
        contentCollectionView.backgroundColor = .black
        contentCollectionView.collectionViewLayout = collectionViewLayout()
    }
    
    func collectionViewLayout() -> UICollectionViewFlowLayout {
       
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 8 * 4
        
        layout.itemSize = CGSize(width: width / 3.4, height: width / 3.4 / 165 * 247.5)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .horizontal

        return layout
    }
}
