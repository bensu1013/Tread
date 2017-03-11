//
//  ObstacleFactory.swift
//  Tread
//
//  Created by Benjamin Su on 3/6/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import SpriteKit

typealias levelSpawn = [(CGFloat, ObstacleType)]
var spawnMachine: [String : levelSpawn] = ["level1":[(0,.redCrate),
                                    (-200,.redCrate),
    (100,.redCrate),
    (210,.redCrate),
    (90,.redCrate),
    (220,.redCrate),
    (80,.redCrate),
    ]]


class ObstacleFactory {
    
    var obstacles = Set<Obstacle>()
    weak var scene: SKScene!
    
    var currentLevel: levelSpawn?
    var objectCounter = 0
    
    private var redCrateTexture = SKTexture(image: #imageLiteral(resourceName: "redcrate"))
    
    
    init(scene: SKScene) {
        self.scene = scene
        
        getLevel(with: "level1")
        startLevel()
    }
    
    deinit {
        print("good bye cruel world")
    }
    
    func getLevel(with: String) {
        if let level = spawnMachine[with] {
            currentLevel = level
        }
    }
    
    func startLevel() {
        
        guard let level = currentLevel else { return }
        
        let main = SKAction.run {
            print(self.objectCounter)
            self.createNewObstacle(type: level[self.objectCounter])
            self.objectCounter += 1
        }
        
        let delay = SKAction.wait(forDuration: 0.4)
        
        let seq = SKAction.sequence([ main, delay])
        
        let rep = SKAction.repeat(seq, count: level.count)
        
        scene.run(rep, withKey: "creatingRedCrates")
    }
    
    func createNewObstacle(type: (CGFloat, ObstacleType)) {
        
        let obstacle = Obstacle(texture: redCrateTexture, color: UIColor.red, size: CGSize(width: 64.0, height: 64.0), type: type.1)
        
//        let startX = CGFloat(arc4random_uniform(UInt32(scene.frame.width))) - (scene.frame.width / 2)
        
        obstacle.position = CGPoint(x: type.0, y: scene.frame.height / 2)
        
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
