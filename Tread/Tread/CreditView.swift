//
//  CreditView.swift
//  Tread
//
//  Created by Benjamin Su on 3/21/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import UIKit

class CreditView: UIView {
    
    let textField = UITextView()
    let doneButton = UIButton()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.cyan
        
        loadTextField()
        loadDoneButton()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        
    }
    
    @objc func doneButtonAction() {
        NotificationCenter.default.post(name: Notification.Name.landingVC, object: nil)
    }
}

extension CreditView {
    
    func loadTextField() {
        textField.frame = CGRect(x: frame.width * 0.25, y: frame.height * 0.1, width: frame.width * 0.5, height: frame.height * 0.65)
        textField.backgroundColor = UIColor.clear
        textField.textAlignment = .center
        textField.isUserInteractionEnabled = false
        self.addSubview(textField)
        textField.font = Fonts.credit
        textField.text = "Thanks To:\n Kenney.nl for the awesome sprites\n\n Created By:\n Benjamin Su"
        
    }
    
    func loadDoneButton() {
        doneButton.frame = CGRect(x: frame.width * 0.35, y: frame.height * 0.75, width: frame.width * 0.3, height: frame.height * 0.1)
        doneButton.addTarget(self, action: #selector(doneButtonAction), for: .touchUpInside)
        doneButton.backgroundColor = UIColor.green
        doneButton.setTitle("Done", for: .normal)
        self.addSubview(doneButton)
    }
}
