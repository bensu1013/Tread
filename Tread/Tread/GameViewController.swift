//
//  GameViewController.swift
//  Tread
//
//  Created by Benjamin Su on 3/6/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    let skView = SKView()
    let hud = HudLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        skView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: self.view.frame.width, height: self.view.frame.height * 0.75))
            
            // Load the SKScene from 'GameScene.sks'
        if let scene = SKScene(fileNamed: "GameScene") as? GameScene {
            
            scene.gameSceneDelegate = self
            
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            skView.presentScene(scene)
        }
        
        skView.ignoresSiblingOrder = true
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        self.view.addSubview(skView)
        self.view.addSubview(hud.view)
        
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension GameViewController: GameSceneDelegate {
    
    func contactPlayerObstacle() {
        
        hud.healthText.text = "\(Player.main.health.getCurrent())/\(Player.main.health.maximum)"
        hud.coinText.text = "Coins: \(Player.main.stats.coins)"
    }
    
}

