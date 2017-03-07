//
//  GameScene.swift
//  Tread
//
//  Created by Benjamin Su on 3/6/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var player = Player(texture: nil, color: UIColor.blue, size: CGSize(width: 64, height: 64))
    var previousTime: Double = 0
    
    var obstacleFactory: ObstacleFactory!
    
    override func didMove(to view: SKView) {
      
        setupPhysicsWorld()
        
        self.addChild(player)
        obstacleFactory = ObstacleFactory(scene: self)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            
            player.movePoint = touch.location(in: self)
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            
            player.movePoint = touch.location(in: self)
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

    
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        var dt: Double = 0
        
        if previousTime == 0 {
            previousTime = currentTime
        } else {
            dt = currentTime - previousTime
        }
        
        
        player.update(dt: dt)
        if player.health.current <= 0 {
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
        
            if let player = a.node as? Player {
                
                if let obstacle = b.node as? Obstacle {
                    print("ouch")
                    player.touched(by: obstacle.type)
                    
                }
                
            }
            
            
            
        }
        
    }
    
}

