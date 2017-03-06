//
//  ObstacleFactory.swift
//  Tread
//
//  Created by Benjamin Su on 3/6/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import SpriteKit

enum ObstacleType {
    
}

class ObstacleFactory {
    
    var obstacles = Set<Obstacle>()
    weak var scene: SKScene!
    
    init(scene: SKScene) {
        self.scene = scene
        
        let seq = SKAction.sequence([
            SKAction.run { self.createNewObstacle() },
            SKAction.wait(forDuration: 2.0)
            ])
        
        let rep = SKAction.repeatForever(seq)
        
        scene.run(rep)
        
    }
    
    
    func createNewObstacle() {
        
        let obstacle = Obstacle(texture: nil, color: UIColor.red, size: CGSize(width: 32.0, height: 32.0))
        
        let startX = CGFloat(arc4random_uniform(UInt32(scene.frame.width))) - (scene.frame.width / 2)
        
        obstacle.position = CGPoint(x: startX, y: scene.frame.height / 2)
        
        obstacles.insert(obstacle)
        scene?.addChild(obstacle)
        
    }
    
    
    

}
