//
//  UIExtensions.swift
//  Tread
//
//  Created by Benjamin Su on 3/24/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import UIKit

//Color scheme
extension UIColor {
    
    static var theme1: UIColor {
        return UIColor(colorLiteralRed: 170/255, green: 184/255, blue: 154/255, alpha: 1.0)
    }
    static var theme2: UIColor {
        return UIColor(colorLiteralRed: 255/255, green: 244/255, blue: 128/255, alpha: 1.0)
    }
    static var theme3: UIColor {
        return UIColor(colorLiteralRed: 224/255, green: 255/255, blue: 255/255, alpha: 1.0)
    }
    static var theme4: UIColor {
        return UIColor(colorLiteralRed: 133/255, green: 193/255, blue: 230/255, alpha: 1.0)
    }
    static var theme5: UIColor {
        return UIColor(colorLiteralRed: 166/255, green: 234/255, blue: 213/255, alpha: 1.0)
    }
}

extension UIButton {
    
    //Method used to for uniformed button style
    func setToTheme(title: String, corner: Bool = true) {
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(UIColor.darkGray, for: .normal)
        self.backgroundColor = UIColor.theme2
        if corner {
            self.layer.cornerRadius = self.frame.height / 5.0
        }
        
    }
    
}
