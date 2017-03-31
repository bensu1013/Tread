//
//  FallingObject.swift
//  Tread
//
//  Created by Benjamin Su on 3/6/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import SpriteKit

enum ObstacleType: Int {
    case none, redCrate, goldCoin, spikeTrap
}


class Obstacle: SKSpriteNode {
    
    var type: ObstacleType = .none
    var willRemove = false
    
    
    init(texture: SKTexture?, color: UIColor, size: CGSize, type: ObstacleType) {
        super.init(texture: texture, color: color, size: size)
        self.type = type
        createPhysicsBody(type: type)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }    
    
    func contacted() {
        
        switch type {
        case .goldCoin:
            goldCoinTouch()
        case .spikeTrap:
            self.color = UIColor.red
        default:
            break
        }
        
    }
    
}

//Touched methods for types
extension Obstacle {
    
    fileprivate func goldCoinTouch() {
        
        self.physicsBody?.categoryBitMask = 0
        let up = SKAction.moveBy(x: 0.0, y: 100.0, duration: 0.2)
        let pop = SKAction.fadeOut(withDuration: 0.5)
        self.run(SKAction.sequence([up,pop])) { 
            self.willRemove = true
        }
    }
    
}

//PhysicsBody
extension Obstacle {
    
    func createPhysicsBody(type: ObstacleType) {
        
        self.physicsBody = SKPhysicsBody(rectangleOf: self.frame.size)
        self.physicsBody?.pinned = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = BitMask.obstacle
        self.physicsBody?.contactTestBitMask = BitMask.player | BitMask.screenBorder
        self.physicsBody?.affectedByGravity = false
        
        switch type {
        case .redCrate:
            self.physicsBody?.collisionBitMask = BitMask.player
        default:
            self.physicsBody?.collisionBitMask = UInt32.allZeros
            self.physicsBody?.pinned = false
        }
        
    }
    
}
