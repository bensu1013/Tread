//
//  HudHealthBar.swift
//  Tread
//
//  Created by Benjamin Su on 3/28/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import UIKit

class HudHealthBar: UIView {

    var healthBar = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.black
        
        loadSubviews()
        print("healthbar")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
}



extension HudHealthBar {
    
    fileprivate func loadSubviews() {
        loadHealthBar()
    }
    
    private func loadHealthBar() {
        healthBar.frame = self.bounds
        healthBar.backgroundColor = UIColor.red
        self.addSubview(healthBar)
    }
    
}
