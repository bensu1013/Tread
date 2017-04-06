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
        
        hud.hudDelegate = self
        
        // Set view to appropriate frame
        skView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: self.view.frame.width, height: self.view.frame.height * 0.75))
        skView.ignoresSiblingOrder = true
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        createNewScene()
        
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
    
    fileprivate func createNewScene() {
        
        Player.main.sprite.removeFromParent()
        Player.main.reset()
        hud.reloadCoins(amount: 0)
        hud.healthBar.resetHealthBar()
        // Creates new instance of scene
        let scene = GameLevelScene(size: CGSize(width: 640, height: 800))
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        // Set delegates to communicate with VC
        scene.gameSceneDelegate = self
        let transition = SKTransition.crossFade(withDuration: 1.0)
        skView.presentScene(scene, transition: transition)
        
    }
    
}

extension GameLevelViewController: GameSceneDelegate {
    
    func updateHud() {
        
        hud.healthBar.reloadHealthBar()
        hud.reloadCoins(amount: Player.main.stats.coins)
        
    }
    
    func levelCompleted(stars: Int) {
        
        skView.scene?.isPaused = true
        let completeView = GameLevelCompleteView(frame: view.frame, stars: stars)
        completeView.menuDelegate = self
        view.addSubview(completeView)
        
    }
    
    func gameOver() {
        
        skView.scene?.isPaused = true
        let overView = GameLevelOverView(frame: view.frame)
        overView.menuDelegate = self
        view.addSubview(overView)
        
    }
    
}

extension GameLevelViewController: HUDLayerDelegate {
    
    func showMenu() {
        skView.scene?.isPaused = true
        let menu = GameLevelMenuView(frame: view.frame)
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
    
    func nextLevelAction() {
        
        self.createNewScene()
        
    }
    
    func replayAction() {
        
        self.createNewScene()
        
    }
    
}


