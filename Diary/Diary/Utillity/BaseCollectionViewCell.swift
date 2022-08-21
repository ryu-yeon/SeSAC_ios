//
//  BaseCollectionViewCell.swift
//  Diary
//
//  Created by 유연탁 on 2022/08/22.
//

import UIKit

class BaseCellectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        
    }
    
    func setConstraints() {
        
    }
}
