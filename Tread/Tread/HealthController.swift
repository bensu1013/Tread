//
//  HealthController.swift
//  Tread
//
//  Created by Benjamin Su on 3/6/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import SpriteKit

class HealthController {
    
    var maximum: Int {
        get { return 10 + (vitality * 2) }
    }
    fileprivate var current: Int = 10
    var vitality = 1
    var canHurt = true
    
    init() {
        current = maximum
    }
    
    func getCurrent() -> Int {
        return current
    }
    
    func resetCurrent() {
        current = maximum
    }
    
    func setVitality(by vit: Vitality) {
        vitality = vit.currentVit
    }
    
    
    func gotHurt(by type: ObstacleType) {
        if canHurt {
            switch type {
            case .redCrate:
                basicContact()
            default:
                break
            }
        }
        if current < 0 { current = 0 }
    }
    
    func gotHealed() {
        
    }
    
}

//ObstacleType scenario methods
extension HealthController {
    
    func basicContact() {
        current -= 2
        canHurt = false
    }
    
}





