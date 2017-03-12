//
//  StageLayout.swift
//  Tread
//
//  Created by Benjamin Su on 3/11/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import UIKit

typealias levelSpawn = [(CGFloat, ObstacleType)]

class StageLayout {
    
    static func loadStage(with name: String) {
        
        let stageContents = readDataFromFile(named: name)
        
        let stageObjects = stageParser(with: stageContents)
        
        print(stageObjects)
        
    }
    
    private static func stageParser(with contents: String?) -> [[String]] {
        let csv = contents
        
        guard let unwrappedcsv = csv else { return [["Error"]] }
        
        var stageLayout = [[String]]()
        var objects = [String]()
        
        let lines: [String] = unwrappedcsv.components(separatedBy: NSCharacterSet.newlines) as [String]
        
        for row in lines {
            
            if row != "" {
                objects = row.components(separatedBy: ",")
                
                stageLayout.append(objects)
            }
        }
        return stageLayout
    }
    
    private static func readDataFromFile(named: String) -> String? {
        guard let filePath = Bundle.main.path(forResource: named, ofType: "csv") else { return nil }
        
        do {
            let contents = try String(contentsOfFile: filePath, encoding: .utf8)
            return contents
        } catch {
            print("File failed for \(filePath) with \(error)")
            return nil
        }
    }
    
}


