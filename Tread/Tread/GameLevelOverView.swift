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
    
    let mainView = UIView()
    let coinsLabel = UILabel()
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
        
        backgroundColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7)
        loadMainView()
        loadCoinsLabel()
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
    
    private func loadCoinsLabel() {
        
        coinsLabel.frame = CGRect(x: mainView.frame.size.width * 0.25, y: mainView.frame.size.height * 0.2, width: mainView.frame.size.width * 0.5, height: mainView.frame.size.height * 0.2)
        coinsLabel.text = "\(Player.main.stats.coins)"
        coinsLabel.textColor = UIColor.darkGray
        mainView.addSubview(coinsLabel)
        
    }
    
    private func loadExitButton() {
        
        exitButton.frame = CGRect(x: mainView.frame.size.width * 0.1, y: mainView.frame.size.height * 0.7, width: mainView.frame.size.width * 0.2, height: mainView.frame.size.height * 0.15)
        exitButton.addTarget(self, action: #selector(exitButtonAction), for: .touchUpInside)
        exitButton.setToTheme(title: "<")
        mainView.addSubview(exitButton)
        
    }
    
    private func loadNextLevelButton() {
        
        nextLevelButton.frame = CGRect(x: mainView.frame.size.width * 0.7, y: mainView.frame.size.height * 0.7, width: mainView.frame.size.width * 0.2, height: mainView.frame.size.height * 0.15)
        nextLevelButton.addTarget(self, action: #selector(nextLevelButtonAction), for: .touchUpInside)
        nextLevelButton.setToTheme(title: ">")
        if !isNextAvailable {
            nextLevelButton.isUserInteractionEnabled = false
        }
        mainView.addSubview(nextLevelButton)
        
    }
    
    private var isNextAvailable: Bool {
        return StageLayout.levelToLoad < LevelSelectionInfo.levels.count
    }
    
    private func loadReplayButton() {
        replayButton.frame = CGRect(x: mainView.frame.size.width * 0.4, y: mainView.frame.size.height * 0.7, width: mainView.frame.size.width * 0.2, height: mainView.frame.size.height * 0.15)
        replayButton.addTarget(self, action: #selector(replayButtonAction), for: .touchUpInside)
        replayButton.setToTheme(title: "@")
        mainView.addSubview(replayButton)
    }
}
    

