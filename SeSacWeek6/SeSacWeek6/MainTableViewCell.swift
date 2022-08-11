//
//  MainTableViewCell.swift
//  SeSacWeek6
//
//  Created by 유연탁 on 2022/08/09.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        print("MainTableViewCell", #function)

        setupUI()
    }
    
    func setupUI() {
        
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.text = "넷플릭스 인기 콘텐츠"
        titleLabel.backgroundColor = .clear
        
        contentCollectionView.backgroundColor = .clear
        contentCollectionView.collectionViewLayout = collectionViewLayout()
    }
    
    func collectionViewLayout() -> UICollectionViewFlowLayout {
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 16
        
        layout.itemSize = CGSize(width: 300, height: 180)
        layout.sectionInset = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .horizontal
    
        return layout
    }

}
