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
    
    weak var scene: SKScene!
    
    var obstacles = Set<Obstacle>()
    
    var objectCounter = 0
    
    private let redCrateTexture = SKTexture(image: #imageLiteral(resourceName: "redcrate"))
    
    
    init(scene: SKScene) {
        self.scene = scene
        
        readStage(layout: StageLayout.loadStage(with: "LevelOne"))
        
     
    }
    
    deinit {
        print("good bye cruel world")
    }

    
    
    func readStage(layout: [[ObstacleType]]) {
        
        for (i, row) in layout.enumerated() {
            for (j, column) in row.enumerated() {
                
                switch column {
                case .none:
                    break
                default:
                    let x = CGFloat(j * 64) - scene.frame.width / 2
                    let y = CGFloat(i * -64) + scene.frame.height + CGFloat(layout.count) * 64
                    
                    createObstacle(at: CGPoint.init(x: x, y: y), as: column)
                }
            }
        }
    }
    
    func createObstacle(at point: CGPoint, as type: ObstacleType) {
        let obstacle = Obstacle(texture: redCrateTexture, color: UIColor.red, size: CGSize(width: 64.0, height: 64.0), type: type)
        
        obstacle.position = point
        
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
