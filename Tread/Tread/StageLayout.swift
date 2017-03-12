//
//  StageLayout.swift
//  Tread
//
//  Created by Benjamin Su on 3/11/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import UIKit


class StageLayout {
    
    static func loadStage(with name: String) -> [[ObstacleType]] {
        
        let stageContents = readDataFromFile(named: name)
        
        let stageObjects = stageParser(with: stageContents)
        
        let stageTypes = readStage(with: stageObjects)
        
        return stageTypes
        
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


