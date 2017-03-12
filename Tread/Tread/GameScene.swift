//
//  GameScene.swift
//  Tread
//
//  Created by Benjamin Su on 3/6/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol GameSceneDelegate {
    func contactPlayerObstacle()
}

class GameScene: SKScene {
    
    var gameSceneDelegate: GameSceneDelegate?
    
    var player = Player.main
    var previousTime: Double = 0
    
    var obstacleFactory: ObstacleFactory!
    
    override func didMove(to view: SKView) {
      
        setupPhysicsWorld()
        
        self.addChild(player.sprite)
        obstacleFactory = ObstacleFactory(scene: self)
        StageLayout.loadStage(with: "LevelOne")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            player.sprite.movePoint = touch.location(in: self)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            player.sprite.movePoint = touch.location(in: self)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        obstacleFactory.pulsate()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        var dt: Double = 0
        
        if previousTime == 0 {
            previousTime = currentTime
        } else {
            dt = currentTime - previousTime
        }
        
        
        player.sprite.update(dt: dt)
        if player.health.getCurrent() <= 0 {
            self.isPaused = true
        }
    }
}


extension GameScene: SKPhysicsContactDelegate {
    
    fileprivate func setupPhysicsWorld() {
        self.physicsWorld.contactDelegate = self
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        var a: SKPhysicsBody!
        var b: SKPhysicsBody!
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            a = contact.bodyA
            b = contact.bodyB
        } else {
            a = contact.bodyA
            b = contact.bodyB
        }
        
        if a.categoryBitMask == BitMask.player && b.categoryBitMask == BitMask.obstacle {
        
            if let player = a.node as? PlayerSprite {
                
                if let obstacle = b.node as? Obstacle {
                    
                    player.touched(by: obstacle)
                    gameSceneDelegate?.contactPlayerObstacle()
                    
                }
                
            }
            
        }
        
    }
    
}

