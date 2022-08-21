//
//  ImageCollectionViewCell.swift
//  Diary
//
//  Created by 유연탁 on 2022/08/22.
//

import UIKit

import SnapKit

class ImageCollectionViewCell: BaseCellectionViewCell {
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .gray
        return view
    }()
    
    override func configureUI() {
        self.addSubview(imageView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.layer.borderWidth = 0
    }
    
    override func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(0)
        }
    }
}
