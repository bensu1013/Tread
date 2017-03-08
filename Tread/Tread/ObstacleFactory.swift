//
//  ObstacleFactory.swift
//  Tread
//
//  Created by Benjamin Su on 3/6/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import SpriteKit

class ObstacleFactory {
    
    var obstacles = Set<Obstacle>()
    weak var scene: SKScene!
    
    init(scene: SKScene) {
        self.scene = scene
        
        let seq = SKAction.sequence([
            SKAction.run { self.createNewObstacle() },
            SKAction.wait(forDuration: 1.0)
            ])
        
        let rep = SKAction.repeatForever(seq)
        
        scene.run(rep)
        
    }
    
    deinit {
        print("good bye cruel world")
    }
    
    func createNewObstacle() {
        
        let obstacle = Obstacle(texture: nil, color: UIColor.red, size: CGSize(width: 32.0, height: 32.0), type: .basic)
        
        let startX = CGFloat(arc4random_uniform(UInt32(scene.frame.width))) - (scene.frame.width / 2)
        
        obstacle.position = CGPoint(x: startX, y: scene.frame.height / 2)
        
        obstacles.insert(obstacle)
        scene?.addChild(obstacle)
        
    }
    
    func pulsate() {
        
        for obstacle in obstacles {
            
            let large = SKAction.scale(to: 1.3, duration: 0.25)
            let medium = SKAction.scale(to: 1.0, duration: 0.25)
            let small = SKAction.scale(to: 0.8, duration: 0.25)
            let sequence = SKAction.sequence([large,small,medium])
            
            obstacle.run(sequence)
            
        }
        
    }
    

}
