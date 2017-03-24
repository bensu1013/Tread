//
//  Constants.swift
//  Tread
//
//  Created by Benjamin Su on 3/6/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit


struct BitMask {
    
    static let player: UInt32 = 0b1
    static let obstacle: UInt32 = 0b10
    static let screenBorder: UInt32 = 0b100
    static let finishLine: UInt32 = 0b1000
    
}

struct Fonts {
    
    static var landing: UIFont {
        
        let size = UIScreen.main.bounds.height / 12
        
        let font = UIFont(name: "Futura-CondensedExtraBold", size: size)
        
        return font!
        
    }
    
    static var score: UIFont {
        
        let size = UIScreen.main.bounds.height / 24
        
        let font = UIFont(name: "Futura-CondensedExtraBold", size: size)
        
        return font!
        
    }
    
    static var credit: UIFont {
        
        let size = UIScreen.main.bounds.height / 20
        
        let font = UIFont(name: "Futura-CondensedExtraBold", size: size)
        
        return font!
        
    }
    
    static var hudlayer: UIFont {
        
        let size = UIScreen.main.bounds.height / 28
        
        let font = UIFont(name: "Futura-CondensedExtraBold", size: size)
        
        return font!
        
    }
    
}
