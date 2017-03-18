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
    case none, redCrate, goldCoin
}


class Obstacle: SKSpriteNode {
    
    var type: ObstacleType = .none
    var willRemove = false
    
    
    init(texture: SKTexture?, color: UIColor, size: CGSize, type: ObstacleType) {
        super.init(texture: texture, color: color, size: size)
        self.type = type
        createPhysicsBody()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }    
    
    func contacted() {
        
        switch type {
        case .goldCoin:
            willRemove = true
        default:
            break
        }
        
        
    }
    
}

//PhysicsBody
extension Obstacle {
    
    func createPhysicsBody() {
        
        self.physicsBody = SKPhysicsBody(rectangleOf: self.frame.size)
        self.physicsBody?.pinned = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = BitMask.obstacle
        self.physicsBody?.collisionBitMask = BitMask.player
        self.physicsBody?.contactTestBitMask = BitMask.player | BitMask.screenBorder
        self.physicsBody?.affectedByGravity = false
        
    }
    
}
