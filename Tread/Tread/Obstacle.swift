//
//  FallingObject.swift
//  Tread
//
//  Created by Benjamin Su on 3/6/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import SpriteKit

class Obstacle: SKSpriteNode {
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        moveObject()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func moveObject() {
        
        let move = SKAction.moveBy(x: 0.0, y: -2000, duration: 5.0)
        
        run(move) { 
            self.removeFromParent()
        }
        
    }
    
    
}
