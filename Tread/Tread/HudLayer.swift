//
//  HudLayer.swift
//  Tread
//
//  Created by Benjamin Su on 3/6/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import UIKit

class HudLayer {
    
    let view = UIView(frame: UIScreen.main.bounds)
    let bottomBar = UIView()
    
    
    init() {
        
        view.isUserInteractionEnabled = false
        loadBottomBar()
        
    }
    
    
}


extension HudLayer {
    
    fileprivate func loadBottomBar() {
        
        bottomBar.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.height * 0.75, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.25)
        view.addSubview(bottomBar)
        
    }
    
}
