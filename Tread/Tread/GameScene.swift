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
    var bottomBorder: SKSpriteNode!
    var obstacleFactory: ObstacleFactory!
    
    override func didMove(to view: SKView) {
      
        setupPhysicsWorld()
        
        self.addChild(player.sprite)
        obstacleFactory = ObstacleFactory(scene: self)
        
        
        let screenNode = SKNode()
        self.addChild(screenNode)
        
        let cam = SKCameraNode()
        screenNode.addChild(cam)
        self.camera = cam
        
        bottomBorder = SKSpriteNode(texture: nil, color: UIColor.blue, size: CGSize.init(width: 640, height: 200))
        bottomBorder.position = CGPoint(x: 0, y: -475)
        self.addChild(bottomBorder)
        bottomBorder.physicsBody = SKPhysicsBody(rectangleOf: bottomBorder.frame.size)
        bottomBorder.physicsBody?.isDynamic = false
        bottomBorder.physicsBody?.categoryBitMask = BitMask.screenBorder
        bottomBorder.physicsBody?.collisionBitMask = BitMask.player 
        bottomBorder.physicsBody?.contactTestBitMask = BitMask.player | BitMask.obstacle
        bottomBorder.physicsBody?.affectedByGravity = false
        
        bottomBorder.run(SKAction.moveBy(x: 0.0, y: 1200 + obstacleFactory.stageSize!, duration: 20.0))
        screenNode.run(SKAction.moveBy(x: 0.0, y: 1200 + obstacleFactory.stageSize!, duration: 20.0))

        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            player.sprite.movePoint = touch.location(in: self)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if (self.view?.frame.contains(touch.location(in: self.view)))! {
                player.sprite.movePoint = touch.location(in: self)
            }
            
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
        
        obstacleFactory.update()
        
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
            a = contact.bodyB
            b = contact.bodyA
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
    
    
    func didEnd(_ contact: SKPhysicsContact) {
        print("ending")
        var a: SKPhysicsBody!
        var b: SKPhysicsBody!
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            a = contact.bodyA
            b = contact.bodyB
        } else {
            a = contact.bodyB
            b = contact.bodyA
        }
        
        if a.categoryBitMask == BitMask.player && b.categoryBitMask == BitMask.screenBorder {
            print("player & border")
        }
        
        if a.categoryBitMask == BitMask.obstacle && b.categoryBitMask == BitMask.screenBorder {
            print("obs and border")
            if let obstacle = a.node as? Obstacle {
                
                obstacle.willRemove = true
                print("remove")
            }
            
        }
        
    }
    
}

