//
//  PlayerStatistics.swift
//  Tread
//
//  Created by Benjamin Su on 3/8/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

struct PlayerStatistics {
    
    var level = Level()
    var vitality = 1
    var strength = 1
    var speed = 100
    
    
    
}


struct Level {
    var maxLvl = 100
    var currentLvl = 1
    
    var currentEXP = 0
    
    var description: String {
        get {
            return "Characters power. More levels mean more stat points!"
        }
    }
    
    mutating func gainExp(amount: Int) {
        currentEXP += amount
    }
    
}

struct Vitality {
    
    var currentVit = 1
    
    
    
    var description: String {
        get {
            return "Character's toughness. Trip on boxes more often!"
        }
    }
    
}
