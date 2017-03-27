//
//  GameLevelOverView.swift
//  Tread
//
//  Created by Benjamin Su on 3/26/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import UIKit

class GameLevelOverView: UIView {
    
    weak var menuDelegate: GameMenuDelegate?
    
    /*
     Time, CoinsCollected/MaxCoins, EXP gained
     if lvl -> charactermenu button
     
     */
    
    let coinsLabel = UILabel()
    let expLabel = UILabel()
    
    let exitButton = UIButton()
    let nextLevelButton = UIButton()
    let replayButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadSubviews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Button selector targets
extension GameLevelOverView {
    
    @objc fileprivate func exitButtonAction() {
        //MainViewController will recieve and change the view state to LevelSelectionVC
        NotificationCenter.default.post(name: Notification.Name.selectionVC, object: nil)
    }
    
    @objc fileprivate func nextLevelButtonAction() {
        
        //Logic for last level completed
        StageLayout.levelToLoad += 1
        self.removeFromSuperview()
        menuDelegate?.nextLevelAction()
        
    }
    
    @objc fileprivate func replayButtonAction() {
        
        self.removeFromSuperview()
        menuDelegate?.replayAction()
        
    }
    
}

//MARK: - Subview Setup
extension GameLevelOverView {
    
    fileprivate func loadSubviews() {
        
        backgroundColor = UIColor.theme4
        layer.cornerRadius = frame.width / 10.0
        loadCoinsLabel()
        loadExpLabel()
        loadExitButton()
        loadNextLevelButton()
        loadReplayButton()
        
    }
    
    private func loadCoinsLabel() {
        
        coinsLabel.frame = CGRect(x: frame.size.width * 0.25, y: frame.size.height * 0.2, width: frame.size.width * 0.5, height: frame.size.height * 0.2)
        coinsLabel.text = "\(Player.main.stats.coins)"
        coinsLabel.textColor = UIColor.darkGray
        addSubview(coinsLabel)
        
    }
    
    private func loadExpLabel() {
        expLabel.frame = CGRect(x: frame.size.width * 0.25, y: frame.size.height * 0.45, width: frame.size.width * 0.5, height: frame.size.height * 0.2)
        expLabel.text = "10"
        expLabel.textColor = UIColor.darkGray
        addSubview(expLabel)
    }
    
    private func loadExitButton() {
        
        exitButton.frame = CGRect(x: frame.size.width * 0.1, y: frame.size.height * 0.7, width: frame.size.width * 0.2, height: frame.size.height * 0.15)
        exitButton.addTarget(self, action: #selector(exitButtonAction), for: .touchUpInside)
        exitButton.setToTheme(title: "<")
        addSubview(exitButton)
        
    }
    
    private func loadNextLevelButton() {
        
        nextLevelButton.frame = CGRect(x: frame.size.width * 0.7, y: frame.size.height * 0.7, width: frame.size.width * 0.2, height: frame.size.height * 0.15)
        nextLevelButton.addTarget(self, action: #selector(nextLevelButtonAction), for: .touchUpInside)
        nextLevelButton.setToTheme(title: ">")
        if !isNextAvailable {
            nextLevelButton.isUserInteractionEnabled = false
        }
        addSubview(nextLevelButton)
        
    }
    
    private var isNextAvailable: Bool {
        return StageLayout.levelToLoad < LevelSelectionInfo.levels.count
    }
    
    private func loadReplayButton() {
        replayButton.frame = CGRect(x: frame.size.width * 0.4, y: frame.size.height * 0.7, width: frame.size.width * 0.2, height: frame.size.height * 0.15)
        replayButton.addTarget(self, action: #selector(replayButtonAction), for: .touchUpInside)
        replayButton.setToTheme(title: "@")
        addSubview(replayButton)
    }
}
    

