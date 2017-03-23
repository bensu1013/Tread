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
    
    private var moveSpeed: CGFloat = 125
    var movePoint: CGPoint?
    var spriteDelegate: PlayerSpriteDelegate?
    
    fileprivate let moveUp     = [SKTexture(image: #imageLiteral(resourceName: "playerU1")),
                               SKTexture(image: #imageLiteral(resourceName: "playerU2")),
                               SKTexture(image: #imageLiteral(resourceName: "playerU3"))]
    fileprivate let moveDown   = [SKTexture(image: #imageLiteral(resourceName: "playerD1")),
                               SKTexture(image: #imageLiteral(resourceName: "playerD2")),
                               SKTexture(image: #imageLiteral(resourceName: "playerD3"))]
    fileprivate let moveLeft   = [SKTexture(image: #imageLiteral(resourceName: "playerL1")),
                               SKTexture(image: #imageLiteral(resourceName: "playerL2")),
                               SKTexture(image: #imageLiteral(resourceName: "playerL3"))]
    fileprivate let moveRight  = [SKTexture(image: #imageLiteral(resourceName: "playerR1")),
                               SKTexture(image: #imageLiteral(resourceName: "playerR2")),
                               SKTexture(image: #imageLiteral(resourceName: "playerR3"))]
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        createPhysicsBody()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(dt: TimeInterval) {
        moveToPoint(dt: dt)
        updateAnimate()
    }
    
    private func moveToPoint(dt: TimeInterval) {
        
        if let point = movePoint {
            
            let stopDist: CGFloat = 15
            
            let dist = calculateDistance(from: point)
           
            if dist > stopDist {
                let travel = moveSpeed * CGFloat(dt) * 2
                let angle = calculateAngle(from: point)
                let yOffset = travel * sin(angle)
                let xOffset = travel * cos(angle)
                self.position = CGPoint(x: position.x + xOffset, y: position.y + yOffset)
                
            } else {
                self.movePoint = nil
            }
            
        }
//        else {
//            
//            let yOffset = moveSpeed * CGFloat(dt)
//            self.position = CGPoint(x: position.x, y: position.y + yOffset)
//            
//        }
    }
    
}

//Animation methods
extension PlayerSprite {
    
    func contactHurt(handler: @escaping () -> () ) {
        
        let alphaDown = SKAction.fadeAlpha(to: 0.4, duration: 0.1)
        let alphaUp = SKAction.fadeAlpha(to: 1.0, duration: 0.1)
        let alphaSeq = SKAction.sequence([alphaDown,alphaUp])
        let alphaRep = SKAction.repeat(alphaSeq, count: 5)
        
        let handle = SKAction.run { handler() }
        let fullSeq = SKAction.sequence([alphaRep, handle])
        run(fullSeq, withKey: "contactHurt")
        
    }
    
    fileprivate func updateAnimate() {
        
        if let point = movePoint {
            
            let rad = Double(calculateAngle(from: point))
            
            if rad < 0.5 && rad > -0.5 {
                if let _ = action(forKey: "animateRight") {
                    
                } else {
                    animateRight()
                }
            } else if rad > 0.5 && rad < 2.64 {
                if let _ = action(forKey: "animateUp") {
                    
                } else {
                    animateUp()
                }
            } else if rad < -0.5 && rad > -2.64 {
                if let _ = action(forKey: "animateDown") {
                    
                } else {
                    animateDown()
                }
            } else if rad > 2.64 || rad < -2.64 {
                if let _ = action(forKey: "animateLeft") {
                    
                } else {
                    animateLeft()
                }
            }
            
        } else {
            if let _ = action(forKey: "animateUp") {
                
            } else {
                animateUp()
            }
        }
        
    }
    
    //Calculates the radians between playersprite and point it moves to
    fileprivate func calculateAngle(from point: CGPoint) -> CGFloat {
        let angle = atan2((point.y - self.position.y), (point.x - self.position.x))
        return angle
    }
    
    fileprivate func calculateDistance(from point: CGPoint) -> CGFloat {
        
        let a = abs(position.x) - abs(point.x)
        let b = abs(position.y) - abs(point.y)
        let distance = sqrt((a * a) + (b * b))
        return distance
        
    }
    
    private func animateUp() {
        let animate = SKAction.animate(with: moveUp, timePerFrame: 0.12)
        run(animate, withKey: "animateUp")
    }
    
    private func animateDown() {
        let animate = SKAction.animate(with: moveDown, timePerFrame: 0.12)
        run(animate, withKey: "animateDown")
    }
    
    private func animateLeft() {
        let animate = SKAction.animate(with: moveLeft, timePerFrame: 0.12)
        run(animate, withKey: "animateLeft")
    }
    
    private func animateRight() {
        let animate = SKAction.animate(with: moveRight, timePerFrame: 0.12)
        run(animate, withKey: "animateRight")
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
    
    fileprivate func createPhysicsBody() {
        
        self.physicsBody = SKPhysicsBody(rectangleOf: self.frame.size)
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = BitMask.player
        self.physicsBody?.collisionBitMask = BitMask.obstacle | BitMask.screenBorder
        self.physicsBody?.contactTestBitMask = BitMask.obstacle | BitMask.screenBorder
        self.physicsBody?.affectedByGravity = false
        
    }
    
}
