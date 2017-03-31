//
//  LevelSelectionCollectionViewCell.swift
//  Tread
//
//  Created by Benjamin Su on 3/23/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import UIKit

class LevelSelectionCollectionViewCell: UICollectionViewCell {
    
    
    let textLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadTextLabel()
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.theme1
        contentView.layer.cornerRadius = 8
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


extension LevelSelectionCollectionViewCell {
    
    fileprivate func loadTextLabel() {
        
        textLabel.frame = bounds
        textLabel.textAlignment = .center
        textLabel.textColor = UIColor.darkGray
        contentView.addSubview(textLabel)
        
    }
    
}
