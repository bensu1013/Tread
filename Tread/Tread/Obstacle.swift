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
    case none, redCrate
}


class Obstacle: SKSpriteNode {
    
    var type: ObstacleType = .redCrate
    var willRemove = false
    
    
    init(texture: SKTexture?, color: UIColor, size: CGSize, type: ObstacleType) {
        super.init(texture: texture, color: color, size: size)
        self.type = type
        createPhysicsBody()

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func moveObject() {
        
        let move = SKAction.moveBy(x: 0.0, y: -3000, duration: 10.0)
        
        run(move) { 
            self.removeFromParent()
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
