//
//  PlayerSprite.swift
//  Tread
//
//  Created by Benjamin Su on 3/8/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import SpriteKit

protocol PlayerSpriteDelegate {
    func touched(by obstacle: Obstacle)
}

class PlayerSprite: SKSpriteNode {
    
    private var moveSpeed: CGFloat = 100
    var movePoint: CGPoint?
    var spriteDelegate: PlayerSpriteDelegate?
    
    let moveUp = [SKTexture(image: #imageLiteral(resourceName: "playerU1")),
                  SKTexture(image: #imageLiteral(resourceName: "playerU2")),
                  SKTexture(image: #imageLiteral(resourceName: "playerU3"))]
    let moveDown = [SKTexture(image: #imageLiteral(resourceName: "playerU1")),
                    SKTexture(image: #imageLiteral(resourceName: "playerU2")),
                    SKTexture(image: #imageLiteral(resourceName: "playerU3"))]
    let moveLeft = [SKTexture(image: #imageLiteral(resourceName: "playerU1")),
                    SKTexture(image: #imageLiteral(resourceName: "playerU2")),
                    SKTexture(image: #imageLiteral(resourceName: "playerU3"))]
    let moveRight = [SKTexture(image: #imageLiteral(resourceName: "playerU1")),
                    SKTexture(image: #imageLiteral(resourceName: "playerU2")),
                    SKTexture(image: #imageLiteral(resourceName: "playerU3"))]
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        createPhysicsBody()
        
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
            
            let dura = 0.2
            
            let move = SKAction.move(to: point, duration: dura)
            
            run(move, completion: {
                self.movePoint = nil
            })
            
        }
    }
    
}

//Contact methods
extension PlayerSprite {
    
    func touched(by obstacle: Obstacle) {
        spriteDelegate?.touched(by: obstacle)
    }
    
}


//PhysicsBody
extension PlayerSprite {
    
    func createPhysicsBody() {
        
        self.physicsBody = SKPhysicsBody(rectangleOf: self.frame.size)
        self.physicsBody?.categoryBitMask = BitMask.player
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = BitMask.obstacle
        self.physicsBody?.affectedByGravity = false
        
    }
    
}
