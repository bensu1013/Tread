//
//  GameLevelViewController.swift
//  Tread
//
//  Created by Benjamin Su on 3/6/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameLevelViewController: UIViewController {
    
    let skView = SKView()
    let hud = HudLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set view to appropriate frame
        skView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: self.view.frame.width, height: self.view.frame.height * 0.75))
        
        // Creates new instance of scene
        let scene = GameLevelScene(size: CGSize(width: 640, height: 800))
        
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        
        // Set delegates to communicate with VC
        scene.gameSceneDelegate = self
        hud.hudDelegate = self
        
        // Present the scene
        skView.presentScene(scene)
        
        
        skView.ignoresSiblingOrder = true
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        
        self.view.addSubview(hud.view)
        self.view.addSubview(skView)
        
        
    }

    deinit {
        
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension GameLevelViewController: GameSceneDelegate {
    
    func contactPlayerObstacle() {
        
        hud.healthText.text = "\(Player.main.health.getCurrent())/\(Player.main.health.maximum)"
        hud.coinText.text = "Coins: \(Player.main.stats.coins)"
        
    }
    
    //cant create new gamescene when old one is still in use, overlapping player nodes
    func levelCompleted() {
        
        skView.scene?.isPaused = true
        let stats = GameLevelCompleteView(frame: CGRect(x: view.frame.size.width * 0.1, y: view.frame.size.height * 0.1, width: view.frame.size.width * 0.8, height: view.frame.size.height * 0.55))
        
        view.addSubview(stats)
        
    }
    
}

extension GameLevelViewController: HUDLayerDelegate {
    
    func showMenu() {
        skView.scene?.isPaused = true
        let menu = GameLevelMenuView(frame: CGRect(x: view.frame.size.width * 0.2, y: view.frame.size.height * 0.2, width: view.frame.size.width * 0.6, height: view.frame.size.height * 0.45))
        menu.menuDelegate = self
        view.addSubview(menu)
    }
    
}

extension GameLevelViewController: GameMenuDelegate {
    
    func exitAction() {
        
    }
    
    func resumeAction() {
        skView.scene?.isPaused = false
    }
    
}


