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
    
    let exitButton = UIButton()
    let resumeButton = UIButton()
    
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
        
        backgroundColor = UIColor.yellow
        loadExitButton()
        loadResumeButton()
        
    }
    
    private func loadExitButton() {
        
        exitButton.frame = CGRect(x: frame.size.width * 0.25, y: frame.size.height * 0.25, width: frame.size.width * 0.5, height: frame.size.height * 0.2)
        exitButton.addTarget(self, action: #selector(exitButtonAction), for: .touchUpInside)
        exitButton.setTitle("Exit", for: .normal)
        addSubview(exitButton)
        
    }
    
    @objc private func exitButtonAction() {
        
//        menuDelegate?.exitAction()
        NotificationCenter.default.post(name: Notification.Name.selectionVC, object: nil)
        
    }
    
    private func loadResumeButton() {
        
        resumeButton.frame = CGRect(x: frame.size.width * 0.25, y: frame.size.height * 0.5, width: frame.size.width * 0.5, height: frame.size.height * 0.2)
        resumeButton.addTarget(self, action: #selector(resumeButtonAction), for: .touchUpInside)
        resumeButton.setTitle("Resume", for: .normal)
        addSubview(resumeButton)
        
    }
    
    @objc private func resumeButtonAction() {
        
//        menuDelegate?.resumeAction()
        self.removeFromSuperview()
        
    }
}
