//
//  HudLayer.swift
//  Tread
//
//  Created by Benjamin Su on 3/6/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import UIKit

protocol HUDLayerDelegate: class {
    func showMenu()
}

class HudLayer {
    
    let view = UIView(frame: UIScreen.main.bounds)
    let bottomBar = UIView()
    
    var healthBar: HudHealthBar?
    let healthText = UILabel()
    let coinText = UILabel()
    
    let menuButton = UIButton()
    
    weak var hudDelegate: HUDLayerDelegate?
    
    init() {
        
        
        
        loadBottomBar()
        healthBar = HudHealthBar(frame: CGRect(x: 50.0, y: 50.0, width: 100.0, height: 44.0))
        bottomBar.addSubview(healthBar!)
        loadHealthText()
        loadCoinText()
        loadMenuButton()
        
    }
    
}

//MARK: -Methods of interaction
extension HudLayer {
    
    @objc fileprivate func menuButtonAction() {
        hudDelegate?.showMenu()
    }
    
}

//MARK: -Subview Setup
extension HudLayer {
    
    fileprivate func loadBottomBar() {
        
        bottomBar.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.height * 0.75, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.25)
        bottomBar.backgroundColor = UIColor.theme1
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
    
    fileprivate func loadMenuButton() {
        
        menuButton.frame = CGRect(x: 200.0, y: 50.0, width: 100.0, height: 44.0)
        menuButton.setToTheme(title: "Menu")
        menuButton.addTarget(self, action: #selector(menuButtonAction), for: .touchUpInside)
        bottomBar.addSubview(menuButton)
    }
    
}
