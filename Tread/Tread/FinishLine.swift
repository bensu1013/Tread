//
//  FinishLine.swift
//  Tread
//
//  Created by Benjamin Su on 3/23/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import SpriteKit

class FinishLine: SKSpriteNode {
    
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        createPhysicsBody()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

//Touched methods for types
extension FinishLine {
    
}

//PhysicsBody
extension FinishLine {
    
    func createPhysicsBody() {
        
        self.physicsBody = SKPhysicsBody(rectangleOf: self.frame.size)
        self.physicsBody?.pinned = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = BitMask.finishLine
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = BitMask.player
        self.physicsBody?.affectedByGravity = false
        
    }
    
}
