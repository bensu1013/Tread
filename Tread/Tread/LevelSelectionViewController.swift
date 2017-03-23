//
//  LevelSelectionViewController.swift
//  Tread
//
//  Created by Benjamin Su on 3/23/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import UIKit

class LevelSelectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let selectionView = LevelSelectionView(frame: self.view.frame)
        self.view = selectionView

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
