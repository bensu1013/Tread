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
    var checkScores = UIButton()
    var credits = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let backView = SKView(frame: frame)
        let landingScene = SKScene(fileNamed: "LandingScene")
        landingScene?.scaleMode = .aspectFit
        backView.presentScene(landingScene)
        self.addSubview(backView)
        loadSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        
    }
    
    @objc fileprivate func startGameAction() {
        NotificationCenter.default.post(name: Notification.Name.gameVC, object: nil)
    }
    
    @objc fileprivate func checkScoresAction() {
        NotificationCenter.default.post(name: Notification.Name.scoreVC, object: nil)
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
        loadCheckScoresButton()
        loadCreditsButton()
        
    }
    
    private func loadTitleLabel() {
        titleLabel.frame = CGRect(x: frame.width * 0.2, y: frame.height * 0.1, width: frame.width * 0.6, height: frame.height * 0.15)
        titleLabel.layer.cornerRadius = 10
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textAlignment = .center
        titleLabel.font = Fonts.landing
        titleLabel.text = "Pop Em'"
        self.addSubview(titleLabel)
    }
    
    private func loadStartGameButton() {
        startGame.frame = CGRect(x: frame.width * 0.3, y: frame.height * 0.4, width: frame.width * 0.4, height: frame.height * 0.12)
        startGame.layer.cornerRadius = 10
        startGame.backgroundColor = UIColor.green
        startGame.setTitle("Start", for: .normal)
        startGame.addTarget(self, action: #selector(startGameAction), for: .touchUpInside)
        self.addSubview(startGame)
    }
    
    private func loadCheckScoresButton() {
        checkScores.frame = CGRect(x: frame.width * 0.3, y: frame.height * 0.53, width: frame.width * 0.4, height: frame.height * 0.12)
        checkScores.layer.cornerRadius = 10
        checkScores.backgroundColor = UIColor.yellow
        checkScores.setTitle("Scores", for: .normal)
        checkScores.addTarget(self, action: #selector(checkScoresAction), for: .touchUpInside)
        self.addSubview(checkScores)
    }
    
    private func loadCreditsButton() {
        credits.frame = CGRect(x: frame.width * 0.3, y: frame.height * 0.66, width: frame.width * 0.4, height: frame.height * 0.12)
        credits.layer.cornerRadius = 10
        credits.backgroundColor = UIColor.brown
        credits.setTitle("Credits", for: .normal)
        credits.addTarget(self, action: #selector(creditsAction), for: .touchUpInside)
        self.addSubview(credits)
    }
    
}
