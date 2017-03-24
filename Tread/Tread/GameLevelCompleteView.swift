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
    
//    weak var menuDelegate: GameMenuDelegate?
    
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
        
        backgroundColor = UIColor.cyan
        loadCoinsLabel()
        loadExpLabel()
        loadExitButton()
        loadNextLevelButton()
        
    }
    

    private func loadCoinsLabel() {
        
        coinsLabel.frame = CGRect(x: frame.size.width * 0.25, y: frame.size.height * 0.25, width: frame.size.width * 0.5, height: frame.size.height * 0.2)
        coinsLabel.text = "\(Player.main.stats.coins)"
        addSubview(coinsLabel)
        
    }
    
    private func loadExpLabel() {
        
    }
    
    private func loadExitButton() {
        
        exitButton.frame = CGRect(x: frame.size.width * 0.1, y: frame.size.height * 0.7, width: frame.size.width * 0.35, height: frame.size.height * 0.2)
        exitButton.addTarget(self, action: #selector(exitButtonAction), for: .touchUpInside)
        exitButton.setTitle("Exit", for: .normal)
        addSubview(exitButton)
        
    }
    
    @objc private func exitButtonAction() {
        
//        menuDelegate?.exitAction()
        NotificationCenter.default.post(name: Notification.Name.selectionVC, object: nil)
        
    }
    
    private func loadNextLevelButton() {
        
        nextLevelButton.frame = CGRect(x: frame.size.width * 0.6, y: frame.size.height * 0.7, width: frame.size.width * 0.35, height: frame.size.height * 0.2)
        nextLevelButton.addTarget(self, action: #selector(nextLevelButtonAction), for: .touchUpInside)
        nextLevelButton.setTitle("Next", for: .normal)
        addSubview(nextLevelButton)
        
    }
    
    @objc private func nextLevelButtonAction() {
        
//        menuDelegate?.resumeAction()
        
        //Logic for last level completed
        StageLayout.levelToLoad += 1
        NotificationCenter.default.post(name: Notification.Name.gameVC, object: nil)
        self.removeFromSuperview()
        
    }
}
