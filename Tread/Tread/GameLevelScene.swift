//
//  GameLevelScene.swift
//  Tread
//
//  Created by Benjamin Su on 3/6/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol GameSceneDelegate: class {
    func contactPlayerObstacle()
    func levelCompleted()
}

class GameLevelScene: SKScene {
    
    weak var gameSceneDelegate: GameSceneDelegate?
    
    var player = Player.main
    var previousTime: Double = 0
    var bottomBorder: SKSpriteNode!
    var leftBorder: SKSpriteNode!
    var rightBorder: SKSpriteNode!
    var obstacleFactory: ObstacleFactory!
    
    let screenNode = SKNode()
    var roundStarted = false
    
    override init(size: CGSize) {
        super.init(size: size)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
      
        setupPhysicsWorld()
        
        self.addChild(player.sprite)
        obstacleFactory = ObstacleFactory(scene: self)
        self.addChild(screenNode)
        
        let cam = SKCameraNode()
        screenNode.addChild(cam)
        self.camera = cam
        
        self.isPaused = true
        
        setupTilemap()
        setupScreenBorders()
    }
    
    deinit {
        player.reset()
    }
    
    func startRound() {
        
        player.isControlled = true
        startScreenScrolling()
        
    }
    
    func startScreenScrolling() {
        let yDist = 640 + obstacleFactory.stageSize
        let dur: Double = Double(yDist) / 100.0
        bottomBorder.run(SKAction.moveBy(x: 0.0, y: yDist, duration: dur))
        leftBorder.run(SKAction.moveBy(x: 0.0, y: yDist, duration: dur))
        rightBorder.run(SKAction.moveBy(x: 0.0, y: yDist, duration: dur))
        screenNode.run(SKAction.moveBy(x: 0.0, y: yDist, duration: dur))
    }
    
    func stopScreenScrolling() {
        bottomBorder.removeAllActions()
        leftBorder.removeAllActions()
        rightBorder.removeAllActions()
        screenNode.removeAllActions()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if roundStarted {
            if let touch = touches.first {
                if player.isControlled {
                    player.sprite.movePoint = touch.location(in: self)
                }
            }
        } else {
            self.isPaused = false
            roundStarted = true
            startRound()
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if (self.view?.frame.contains(touch.location(in: self.view)))! {
                if player.isControlled {
                    player.sprite.movePoint = touch.location(in: self)
                }
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
            previousTime = currentTime
        }
        
        obstacleFactory.update()
        player.update(dt: dt)
        
    }
}

//MARK: - SceneObjects
extension GameLevelScene {
    
    fileprivate func setupTilemap() {
        
        let tileSet = SKTileSet(named: "TileSet")
        let tileMap = SKTileMapNode(tileSet: tileSet!, columns: 10, rows: Int(size.height / 64 * 2) + Int(obstacleFactory.stageSize / 64), tileSize: CGSize.init(width: 64.0, height: 64.0), fillWith: (tileSet?.tileGroups[0])!)
        self.addChild(tileMap)
        tileMap.fill(with: tileMap.tileSet.tileGroups.first)
        tileMap.position = CGPoint.init(x: 0.0, y: obstacleFactory.stageSize / 2 + size.height/2)
        tileMap.zPosition = -50
        
    }
    
    fileprivate func setupScreenBorders() {
        bottomBorder = SKSpriteNode(texture: nil, color: UIColor.clear, size: CGSize.init(width: 640, height: 100))
        bottomBorder.position = CGPoint(x: 0, y: -440)
        self.addChild(bottomBorder)
        bottomBorder.physicsBody = SKPhysicsBody(rectangleOf: bottomBorder.frame.size)
        bottomBorder.physicsBody?.isDynamic = false
        bottomBorder.physicsBody?.categoryBitMask = BitMask.screenBorder
        bottomBorder.physicsBody?.collisionBitMask = BitMask.player
        bottomBorder.physicsBody?.contactTestBitMask = BitMask.player | BitMask.obstacle
        bottomBorder.physicsBody?.affectedByGravity = false
        
        leftBorder = SKSpriteNode(texture: nil, color: UIColor.clear, size: CGSize.init(width: 100, height: 800))
        leftBorder.position = CGPoint(x: -350, y: 0)
        self.addChild(leftBorder)
        leftBorder.physicsBody = SKPhysicsBody(rectangleOf: leftBorder.frame.size)
        leftBorder.physicsBody?.isDynamic = false
        leftBorder.physicsBody?.categoryBitMask = BitMask.screenBorder
        leftBorder.physicsBody?.collisionBitMask = BitMask.player
        leftBorder.physicsBody?.contactTestBitMask = BitMask.player
        leftBorder.physicsBody?.affectedByGravity = false
        
        rightBorder = SKSpriteNode(texture: nil, color: UIColor.clear, size: CGSize.init(width: 100, height: 800))
        rightBorder.position = CGPoint(x: 350, y: 0)
        self.addChild(rightBorder)
        rightBorder.physicsBody = SKPhysicsBody(rectangleOf: rightBorder.frame.size)
        rightBorder.physicsBody?.isDynamic = false
        rightBorder.physicsBody?.categoryBitMask = BitMask.screenBorder
        rightBorder.physicsBody?.collisionBitMask = BitMask.player
        rightBorder.physicsBody?.contactTestBitMask = BitMask.player
        rightBorder.physicsBody?.affectedByGravity = false
    }
}

//MARK: - Contact Delegate
extension GameLevelScene: SKPhysicsContactDelegate {
    
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
                    obstacle.contacted()
                    gameSceneDelegate?.contactPlayerObstacle()
                    Player.main.gameOver {
                        self.stopScreenScrolling()
                        //show gameoverview
                    }
                }
            }
        }
    }
    
    
    func didEnd(_ contact: SKPhysicsContact) {
        
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
            
        } else if a.categoryBitMask == BitMask.obstacle && b.categoryBitMask == BitMask.screenBorder {
            
            if let obstacle = a.node as? Obstacle {
                
                obstacle.willRemove = true
                
            }
            
        } else if a.categoryBitMask == BitMask.player && b.categoryBitMask == BitMask.finishLine {
            if let line = b.node as? FinishLine {
                if Player.main.sprite.position.y > line.position.y {
                    Player.main.isControlled = false
                    player.finishedLevel {
                        self.gameSceneDelegate?.levelCompleted()
                    }
                }
            }
        }
    }
    
}

