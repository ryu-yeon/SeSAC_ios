//
//  TamagotchiCollectionViewCell.swift
//  Tamagotchi
//
//  Created by 유연탁 on 2022/07/22.
//

import UIKit

class TamagotchiCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TamagotchiCollectionViewCell"
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var nameView: UIView!
    
    //MARK: - 컬렉션 뷰 셀 UI 설정
    func setDesign(item: Int, tamagotchiData: TamagotchiInfo, tamagotchiCount: Int) {
        nameView.backgroundColor = .myBackgroundColor
        
        nameLabel.setText(textFont: .boldSystemFont(ofSize: 14))
        nameLabel.setBorderRound()
        nameLabel.textAlignment = .center
        
        if item < tamagotchiCount {
            imageView.image = UIImage(named: "\(tamagotchiData.tamagotchi[item + 1].number)-6")
            nameLabel.text = tamagotchiData.tamagotchi[item + 1].name
            
        } else {
            imageView.image = UIImage(named: "noImage")
            nameLabel.text = tamagotchiData.tamagotchi[0].name
        }
    }
    
}
