//
//  GameLevelCompleteView.swift
//  Tread
//
//  Created by Benjamin Su on 3/23/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import UIKit

// View to pop up when level is completed

class GameLevelCompleteView: UIView {
    
    weak var menuDelegate: GameMenuDelegate?
    
/*
 Time, CoinsCollected/MaxCoins, EXP gained
 if lvl -> charactermenu button
     
 */
    
    let coinsLabel = UILabel()
    let expLabel = UILabel()
    
    let exitButton = UIButton()
    let nextLevelButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadSubviews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Subview Setup
extension GameLevelCompleteView {
    
    fileprivate func loadSubviews() {
        
        backgroundColor = UIColor.theme4
        layer.cornerRadius = frame.width / 10.0
        loadCoinsLabel()
        loadExpLabel()
        loadExitButton()
        loadNextLevelButton()
        
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
        
        exitButton.frame = CGRect(x: frame.size.width * 0.1, y: frame.size.height * 0.7, width: frame.size.width * 0.35, height: frame.size.height * 0.15)
        exitButton.addTarget(self, action: #selector(exitButtonAction), for: .touchUpInside)
        exitButton.setToTheme(title: "Exit")
        addSubview(exitButton)
        
    }
    
    @objc private func exitButtonAction() {
        //MainViewController will recieve and change the view state to LevelSelectionVC
        NotificationCenter.default.post(name: Notification.Name.selectionVC, object: nil)
    }
    
    private func loadNextLevelButton() {
        
        nextLevelButton.frame = CGRect(x: frame.size.width * 0.6, y: frame.size.height * 0.7, width: frame.size.width * 0.35, height: frame.size.height * 0.15)
        nextLevelButton.addTarget(self, action: #selector(nextLevelButtonAction), for: .touchUpInside)
        nextLevelButton.setToTheme(title: "Next")
        if !isNextAvailable {
            nextLevelButton.isUserInteractionEnabled = false
        }
        addSubview(nextLevelButton)
        
    }
    
    private var isNextAvailable: Bool {
        return StageLayout.levelToLoad < LevelSelectionInfo.levels.count
    }
    
    @objc private func nextLevelButtonAction() {
    
        //Logic for last level completed
        StageLayout.levelToLoad += 1
        self.removeFromSuperview()
        menuDelegate?.nextLevelAction()
        
    }
}
