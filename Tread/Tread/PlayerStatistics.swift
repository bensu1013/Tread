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
    var vitality = Vitality()
    var strength = 1
    var speed = 100
    var coins = 0
    
}


struct Level {
    var maxLvl = 100
    var currentLvl = 1
    
    var experience = Experience()
    
    var description: String {
        get {
            return "Characters power. More levels mean more stat points!"
        }
    }
    
    
    
}

struct Experience {
    
    var current = 0
    
    mutating func gainExp(amount: Int) {
        current += amount
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





