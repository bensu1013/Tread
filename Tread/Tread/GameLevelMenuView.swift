//
//  GameLevelMenuView.swift
//  Tread
//
//  Created by Benjamin Su on 3/23/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

protocol GameMenuDelegate: class {
    func resumeAction()
    func exitAction()
    func nextLevelAction()
    func replayAction()
}

//Redesign view to have something layer completely over viewcontroller with alpha to avoid button pressing

class GameLevelMenuView: UIView {
    
    weak var menuDelegate: GameMenuDelegate?
    
    let mainView = UIView()
    let exitButton = UIButton()
    let resumeButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadSubviews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if !mainView.frame.contains(touch.location(in: self)) {
                menuDelegate?.resumeAction()
                self.removeFromSuperview()
            }
        }
    }
    
}

//MARK: - Subview Setup
extension GameLevelMenuView {
    
    fileprivate func loadSubviews() {
        
        backgroundColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7)
        loadMainView()
        loadExitButton()
        loadResumeButton()
        
    }
    
    private func loadMainView() {
        
        mainView.frame = CGRect(x: frame.size.width * 0.2, y: frame.size.height * 0.1, width: frame.size.width * 0.6, height: frame.size.height * 0.6)
        mainView.backgroundColor = UIColor.theme4
        mainView.layer.cornerRadius = mainView.frame.width / 10.0
        addSubview(mainView)
        
    }
    
    private func loadExitButton() {
        
        exitButton.frame = CGRect(x: mainView.frame.size.width * 0.25, y: mainView.frame.size.height * 0.5, width: mainView.frame.size.width * 0.5, height: mainView.frame.size.height * 0.15)
        exitButton.addTarget(self, action: #selector(exitButtonAction), for: .touchUpInside)
        exitButton.setToTheme(title: "Exit")
        mainView.addSubview(exitButton)
        
    }
    
    @objc private func exitButtonAction() {
        
        menuDelegate?.exitAction()
        NotificationCenter.default.post(name: Notification.Name.selectionVC, object: nil)
        
    }
    
    private func loadResumeButton() {
        
        resumeButton.frame = CGRect(x: mainView.frame.size.width * 0.25, y: mainView.frame.size.height * 0.25, width: mainView.frame.size.width * 0.5, height: mainView.frame.size.height * 0.15)
        resumeButton.addTarget(self, action: #selector(resumeButtonAction), for: .touchUpInside)
        resumeButton.setToTheme(title: "Resume")
        mainView.addSubview(resumeButton)
        
    }
    
    @objc private func resumeButtonAction() {
        
        menuDelegate?.resumeAction()
        self.removeFromSuperview()
        
    }
    
}
