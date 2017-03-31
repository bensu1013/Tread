//
//  HudHealthBar.swift
//  Tread
//
//  Created by Benjamin Su on 3/28/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import UIKit

class HudHealthBar: UIView {
    
    let healthBar = UIView()
    let healthText = UILabel()
    var health = Player.main.stats.health
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.black
        self.layer.cornerRadius = 10
        loadSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func resetHealthBar() {
        healthText.text = "\(health.getCurrent())/\(health.maximum)"
        healthBar.frame = self.bounds
    }
    
    func reloadHealthBar() {
        healthText.text = "\(health.getCurrent())/\(health.maximum)"
        
        let barWidth = self.bounds.width / CGFloat(health.maximum) * CGFloat(health.getCurrent())
        
        if !health.canHurt {
            UIView.animate(withDuration: 1.0, animations: { 
                self.healthBar.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: barWidth, height: self.bounds.height))
            })
        }
        
        
        
    }
    
}


//MARK: - Load subviews
extension HudHealthBar {
    
    fileprivate func loadSubviews() {
        loadHealthBar()
        loadHealthText()
    }
    
    private func loadHealthBar() {
        healthBar.frame = self.bounds
        healthBar.backgroundColor = UIColor.red
        healthBar.layer.cornerRadius = 10
        self.addSubview(healthBar)
    }
    
    private func loadHealthText() {
        
        healthText.frame = self.bounds
        healthText.textAlignment = .center
        healthText.textColor = UIColor.white
        healthText.text = "\(health.getCurrent())/\(health.maximum)"
        self.addSubview(healthText)
    }
}
