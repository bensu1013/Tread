//
//  CreditViewController.swift
//  Tread
//
//  Created by Benjamin Su on 3/21/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import UIKit

class CreditViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let creditView = CreditView(frame: self.view.frame)
        self.view = creditView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
    }
    
    
    
}
