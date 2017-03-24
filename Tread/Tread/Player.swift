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
    var health = HealthController()
    var stats = PlayerStatistics()
    
    var isControlled = false
    
    private init() {
        
        sprite = PlayerSprite(texture: nil, color: UIColor.red, size: CGSize(width: 64, height: 64))
        sprite.spriteDelegate = self
        
    }
    
    func update(dt: TimeInterval) {
        
            sprite.update(dt: dt)
        
    }
    
    func reset() {
        sprite.position = CGPoint.zero
        health.resetCurrent()
        stats.coins = 0
    }
    
}

//Contact methods
extension Player: PlayerSpriteDelegate {
    
    func touched(by obstacle: Obstacle) {
        switch obstacle.type {

        case .redCrate:
            self.health.gotHurt(by: obstacle.type)
            self.sprite.contactHurt {
                self.health.canHurt = true
            }
        case .goldCoin:
            self.stats.coins += 1
        default:
            break
        }
    }
    
}
