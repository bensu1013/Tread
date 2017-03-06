//
//  Player.swift
//  Tread
//
//  Created by Benjamin Su on 3/6/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import SpriteKit

class Player: SKSpriteNode {
    
    private var moveSpeed: CGFloat = 100
    var movePoint: CGPoint?
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(dt: TimeInterval) {
        moveToPoint()
    }
    
    private func moveToPoint() {
        
        if let point = movePoint {
            
            //TODO: - Normalize duration
            
            let dura = 0.5
            
            let move = SKAction.move(to: point, duration: dura)
            
            run(move, completion: { 
                self.movePoint = nil
            })
            
        }
        
    }
    
}
