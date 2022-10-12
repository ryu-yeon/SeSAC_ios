//
//  BaseTableViewCell.swift
//  Memo
//
//  Created by 유연탁 on 2022/08/31.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func  configureUI() {
        
    }
    
    func setConstraints() {
        
    }
}
