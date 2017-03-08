//
//  HealthController.swift
//  Tread
//
//  Created by Benjamin Su on 3/6/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

class HealthController {
    
    var maximum: Int {
        get { return 10 + (vitality * 2) }
    }
    var current = 10
    var vitality = 1
    var canHurt = true
    
    func gotHurt(by type: ObstacleType) {
        if canHurt {
            switch type {
            case .basic:
                current -= 2
            }
        }
        if current < 0 { current = 0 }
    }
    
    func gotHealed() {
        
    }
    
}
