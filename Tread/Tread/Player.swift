//
//  Player.swift
//  Tread
//
//  Created by Benjamin Su on 3/6/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import SpriteKit

class Player {
    
    static var main = Player()
    
    var sprite: PlayerSprite!
    var stats = PlayerStatistics()
    
    var isControlled = false
    
    private init() {
        
        sprite = PlayerSprite(texture: nil, color: UIColor.red, size: CGSize(width: 64, height: 64))
        sprite.spriteDelegate = self
        reset()
        
    }
    
    func update(dt: TimeInterval) {
        
        sprite.update(dt: dt)
        
    }
    
    func reset() {
        sprite.position = CGPoint(x: 0.0, y: -200.0)
        stats.health.resetCurrent()
        stats.coins = 0
    }
    
    func finishedLevel(completion: @escaping () -> () ) {
        sprite.finishedLevelAnimation { completion() }
    }
    
}

//Contact methods
extension Player: PlayerSpriteDelegate {
    
    func touched(by obstacle: Obstacle) {
        switch obstacle.type {

        case .redCrate:
            self.stats.health.gotHurt(by: obstacle.type)
            self.sprite.contactHurtAnimation {
                self.stats.health.canHurt = true
            }
        case .goldCoin:
            self.stats.coins += 1
        case .spikeTrap:
            self.stats.health.gotHurt(by: obstacle.type)
            self.sprite.contactHurtAnimation {
                self.stats.health.canHurt = true
            }
        default:
            break
        }
        
    }
    
    func gameOver(completion: @escaping () -> () ) -> Bool {
        
        if stats.health.getCurrent() == 0 {
            
            isControlled = false
            
            sprite.gameOverAnimation {
                completion()
            }
            return true
        }
        return false
    }
    
}
