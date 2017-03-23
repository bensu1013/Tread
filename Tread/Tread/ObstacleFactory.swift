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
    var stageSize: CGFloat?
    var totalCoins = 0
    
    private let redCrateTexture = SKTexture(image: #imageLiteral(resourceName: "redcrate"))
    private let goldCoinTexture = SKTexture(image: #imageLiteral(resourceName: "goldcoin"))
    
    init(scene: SKScene) {
        self.scene = scene
        
        let stageLayout = StageLayout.loadStage()
        
        readStage(layout: stageLayout)
        stageSize = CGFloat(stageLayout.count) * 64.0
        
    }
    
    deinit {
    }

    func update() {
        
        for obs in obstacles {
            if obs.willRemove {
                obstacles.remove(obs)
                obs.removeFromParent()
            }
        }
    }
    
    func clearStage() {
        for obs in obstacles {
            obstacles.remove(obs)
            obs.removeFromParent()
        }
    }
    
    func readStage(layout: [[ObstacleType]]) {
        
        for (i, row) in layout.enumerated() {
            for (j, column) in row.enumerated() {
                
                switch column {
                case .none:
                    break
                default:
                    let x = CGFloat(j * 64) - scene.frame.width / 2 + 96
                    let y = CGFloat(i * -64) + scene.frame.height + CGFloat(layout.count) * 64
                    createObstacle(at: CGPoint.init(x: x, y: y), as: column)
                }
            }
        }
        
        //TODO: - add finish line with contact to trigger end stage logic
        
    }
    
    private func createObstacle(at point: CGPoint, as type: ObstacleType) {
        guard let texture = getTexture(with: type) else { return }
        let obstacle = Obstacle(texture: texture, color: UIColor.red, size: CGSize(width: 64.0, height: 64.0), type: type)
        
        obstacle.position = point
        
        obstacles.insert(obstacle)
        scene?.addChild(obstacle)
    }
    
    private func getTexture(with type: ObstacleType) -> SKTexture? {
        switch type {
        case .redCrate:
            return redCrateTexture
        case .goldCoin:
            return goldCoinTexture
        default:
            return nil
        }
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
