//
//  LandingView.swift
//  Tread
//
//  Created by Benjamin Su on 3/21/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class LandingView: UIView {
    
    var titleLabel = UILabel()
    var startGame = UIButton()
    var checkStats = UIButton()
    var credits = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        let backView = SKView(frame: frame)
//        let landingScene = SKScene(fileNamed: "LandingScene")
//        landingScene?.scaleMode = .aspectFit
//        backView.presentScene(landingScene)
//        self.addSubview(backView)
        
        backgroundColor = UIColor.theme4
        loadSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        
    }
    
    @objc fileprivate func startGameAction() {
        NotificationCenter.default.post(name: Notification.Name.selectionVC, object: nil)
    }
    
    @objc fileprivate func checkStatsAction() {
//        NotificationCenter.default.post(name: Notification.Name.statsVC, object: nil)
    }
    
    @objc fileprivate func creditsAction() {
        NotificationCenter.default.post(name: Notification.Name.creditVC, object: nil)
    }
    
}

//MARK: - Subviews
extension LandingView {
    
    fileprivate func loadSubviews() {
        
        loadTitleLabel()
        loadStartGameButton()
        loadCheckStatsButton()
        loadCreditsButton()
        
    }
    
    private func loadTitleLabel() {
        titleLabel.frame = CGRect(x: frame.width * 0.15, y: frame.height * 0.2, width: frame.width * 0.7, height: frame.height * 0.12)
        titleLabel.layer.cornerRadius = 10
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textAlignment = .center
        titleLabel.font = Fonts.landing
        titleLabel.text = "Thread"
        self.addSubview(titleLabel)
    }
    
    private func loadStartGameButton() {
        startGame.frame = CGRect(x: frame.width * 0.25, y: frame.height * 0.5, width: frame.width * 0.5, height: frame.height * 0.1)
        startGame.setToTheme(title: "Start")
        startGame.addTarget(self, action: #selector(startGameAction), for: .touchUpInside)
        self.addSubview(startGame)
    }
    
    private func loadCheckStatsButton() {
        checkStats.frame = CGRect(x: frame.width * 0.25, y: frame.height * 0.61, width: frame.width * 0.5, height: frame.height * 0.1)
        checkStats.setToTheme(title: "Stats")
        checkStats.addTarget(self, action: #selector(checkStatsAction), for: .touchUpInside)
        self.addSubview(checkStats)
    }
    
    private func loadCreditsButton() {
        credits.frame = CGRect(x: frame.width * 0.25, y: frame.height * 0.72, width: frame.width * 0.5, height: frame.height * 0.1)
        credits.setToTheme(title: "Credits")
        credits.addTarget(self, action: #selector(creditsAction), for: .touchUpInside)
        self.addSubview(credits)
    }
    
}
