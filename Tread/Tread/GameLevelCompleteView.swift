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
    let starsLabel = UILabel()
    
    let mainView = UIView()
    let exitButton = UIButton()
    let nextLevelButton = UIButton()
    let replayButton = UIButton()
    
    init(frame: CGRect, stars: Int) {
        super.init(frame: frame)
        
        loadSubviews()
        starsLabel.text = "Stars: \(stars)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Button selector targets
extension GameLevelCompleteView {
    
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
extension GameLevelCompleteView {
    
    fileprivate func loadSubviews() {
        
        backgroundColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7)
        loadMainView()
        loadCoinsLabel()
        loadExpLabel()
        loadExitButton()
        loadNextLevelButton()
        loadReplayButton()
        
    }
    
    private func loadMainView() {
        
        mainView.frame = CGRect(x: frame.size.width * 0.2, y: frame.size.height * 0.1, width: frame.size.width * 0.6, height: frame.size.height * 0.6)
        mainView.backgroundColor = UIColor.theme4
        mainView.layer.cornerRadius = mainView.frame.width / 10.0
        addSubview(mainView)
        
    }
    
    private func loadStarsLabel() {
        
        starsLabel.frame = CGRect(x: mainView.frame.size.width * 0.25, y: mainView.frame.size.height * 0.2, width: mainView.frame.size.width * 0.5, height: mainView.frame.size.height * 0.2)
        starsLabel.textColor = UIColor.darkGray
        mainView.addSubview(starsLabel)
        
    }
    
    private func loadCoinsLabel() {
        
        coinsLabel.frame = CGRect(x: mainView.frame.size.width * 0.25, y: mainView.frame.size.height * 0.2, width: mainView.frame.size.width * 0.5, height: mainView.frame.size.height * 0.2)
        coinsLabel.text = "\(Player.main.stats.coins)"
        coinsLabel.textColor = UIColor.darkGray
        mainView.addSubview(coinsLabel)
        
    }
    
    private func loadExpLabel() {
        starsLabel.frame = CGRect(x: mainView.frame.size.width * 0.25, y: mainView.frame.size.height * 0.45, width: mainView.frame.size.width * 0.5, height: mainView.frame.size.height * 0.2)
        starsLabel.text = "10"
        starsLabel.textColor = UIColor.darkGray
        mainView.addSubview(starsLabel)
    }
    
    private func loadExitButton() {
        let viewSize = mainView.frame.size
        let side = viewSize.width * 0.2
        
        exitButton.frame = CGRect(x: viewSize.width * 0.1, y: viewSize.height * 0.7, width: side, height: side)
        exitButton.addTarget(self, action: #selector(exitButtonAction), for: .touchUpInside)
        exitButton.setTo(type: .cancel)
        mainView.addSubview(exitButton)
        
    }
    
    private func loadNextLevelButton() {
        let viewSize = mainView.frame.size
        let side = viewSize.width * 0.2
        
        nextLevelButton.frame = CGRect(x: viewSize.width * 0.7, y: viewSize.height * 0.7, width: side, height: side)
        nextLevelButton.addTarget(self, action: #selector(nextLevelButtonAction), for: .touchUpInside)
        nextLevelButton.setTo(type: .next)
        if !isNextAvailable {
            nextLevelButton.isUserInteractionEnabled = false
        }
        mainView.addSubview(nextLevelButton)
        
    }
    
    private var isNextAvailable: Bool {
        return StageLayout.levelToLoad < LevelSelectionInfo.levels.count
    }
    
    private func loadReplayButton() {
        let viewSize = mainView.frame.size
        let side = viewSize.width * 0.2
        
        replayButton.frame = CGRect(x: viewSize.width * 0.4, y: viewSize.height * 0.7, width: side, height: side)
        replayButton.addTarget(self, action: #selector(replayButtonAction), for: .touchUpInside)
        replayButton.setTo(type: .replay)
        mainView.addSubview(replayButton)
    }
}
