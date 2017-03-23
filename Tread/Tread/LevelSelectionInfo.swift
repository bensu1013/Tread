//
//  LevelSelectionInfo.swift
//  Tread
//
//  Created by Benjamin Su on 3/23/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

/*
 All level csv files are 9 columns
 For each new level added, increase LevelSelectionInfo.levels count by one
 Make sure there is always a 2x2 path available for movement
 */

import Foundation

struct LevelSelectionInfo {
    
    static var levels: [String] {
        return [String].init(repeating: "Level", count: 3)
    }
    
    
}
