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
    var stageSize: CGFloat = 0
    var totalCoins = 0
    
    private let redCrateTexture = SKTexture(image: #imageLiteral(resourceName: "redcrate"))
    private let goldCoinTexture = SKTexture(image: #imageLiteral(resourceName: "goldcoin"))
    
    init(scene: SKScene) {
        self.scene = scene
        
        let stageLayout = StageLayout.loadStage()
        stageSize = CGFloat(stageLayout.count) * 64.0
        readStage(layout: stageLayout)
        
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
                    let y = CGFloat(i * -64) + scene.frame.height / 2 + stageSize
                    createObstacle(at: CGPoint.init(x: x, y: y), as: column)
                }
            }
        }
        
        //Finish line used to trigger level completion logic
        let finish = FinishLine(texture: nil, color: UIColor.green, size: CGSize(width: 640, height: 50))
        finish.position = CGPoint(x: 0.0, y: scene.frame.height * 0.75 + stageSize)
        scene?.addChild(finish)
    }
    
    private func createObstacle(at point: CGPoint, as type: ObstacleType) {
        let texture = getTexture(with: type)
        let obstacle = Obstacle(texture: texture, color: UIColor.blue, size: CGSize(width: 64.0, height: 64.0), type: type)
        
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
    
    
    
}
