//
//  HudLayer.swift
//  Tread
//
//  Created by Benjamin Su on 3/6/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import UIKit

class HudLayer {
    
    let view = UIView(frame: UIScreen.main.bounds)
    let bottomBar = UIView()
    let healthText = UILabel()
    let coinText = UILabel()
    init() {
        
        view.isUserInteractionEnabled = false
        loadBottomBar()
        loadHealthText()
        loadCoinText()
    }
    
    
}


extension HudLayer {
    
    fileprivate func loadBottomBar() {
        
        bottomBar.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.height * 0.75, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.25)
        bottomBar.backgroundColor = UIColor.brown
        view.addSubview(bottomBar)
        
    }
    
    fileprivate func loadHealthText() {
        
        healthText.frame = CGRect(x: 50.0, y: 50.0, width: 100.0, height: 44.0)
        healthText.text = "\(Player.main.health.getCurrent())/\(Player.main.health.maximum)"
        bottomBar.addSubview(healthText)
    }
    
    fileprivate func loadCoinText() {
        coinText.frame = CGRect(x: 50.0, y: 100.0, width: 100.0, height: 44.0)
        coinText.text = "Coins: \(Player.main.stats.coins)"
        bottomBar.addSubview(coinText)
    }
    
}
