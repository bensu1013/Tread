//
//  FallingObject.swift
//  Tread
//
//  Created by Benjamin Su on 3/6/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import SpriteKit

enum ObstacleType {
    case basic
}


class Obstacle: SKSpriteNode {
    
    var type: ObstacleType = .basic
    
    init(texture: SKTexture?, color: UIColor, size: CGSize, type: ObstacleType) {
        super.init(texture: texture, color: color, size: size)
        
        createPhysicsBody()
        moveObject()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func moveObject() {
        
        let move = SKAction.moveBy(x: 0.0, y: -2000, duration: 4.0)
        
        run(move) { 
            self.removeFromParent()
        }
        
    }
    
    
}

//PhysicsBody
extension Obstacle {
    
    func createPhysicsBody() {
        
        self.physicsBody = SKPhysicsBody(rectangleOf: self.frame.size)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = BitMask.obstacle
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = BitMask.player
        self.physicsBody?.affectedByGravity = false
        
    }
    
}
