//
//  StageLayout.swift
//  Tread
//
//  Created by Benjamin Su on 3/11/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import UIKit

final class StageLayout {
    
    static var levelToLoad = 1
    
    static func loadStage() -> [[ObstacleType]] {
        
        let contents = readDataFromFile()
        let objects = stageParser(with: contents)
        let types = readStage(with: objects)
        
        return types
        
    }
    
    private static func readStage(with data: [[String]]) -> [[ObstacleType]] {
        
        var stageColumns = [ObstacleType]()
        var stageRows = [[ObstacleType]]()
        
        for row in data {
            for column in row {
                if let rawType = Int(column) {
                    
                    if let type = ObstacleType(rawValue: rawType) {
                        stageColumns.append(type)
                    }
                }
            }
            stageRows.append(stageColumns)
            stageColumns.removeAll()
        }
        return stageRows
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
    
    private static func readDataFromFile() -> String? {
        let levelName = "Level\(levelToLoad)"
        guard let filePath = Bundle.main.path(forResource: levelName, ofType: "csv") else { return nil }
        
        do {
            let contents = try String(contentsOfFile: filePath, encoding: .utf8)
            return contents
        } catch {
            print("File failed for \(filePath) with \(error)")
            return nil
        }
    }
    
}
