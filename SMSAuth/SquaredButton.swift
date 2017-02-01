//
//  SquaredButton.swift
//  SMSAuth
//
//  Created by Andrew Platkin on 1/30/17.
//  Copyright © 2017 Andrew Platkin. All rights reserved.
//

import UIKit

class SquaredButton: UIButton {

    // Constants
    let bgColor: UIColor = Config.color.slateBlue
    let greenColor: UIColor = Config.color.limeGreen
    let buttonFont: UIFont = UIFont.systemFont(ofSize: 16.0)
    
    init(frame: CGRect, text: String) {
        super.init(frame: frame)
    
        self.setTitle(text, for: .normal)
        
        // Default Configuration
        self.layer.borderColor = bgColor.cgColor
        self.layer.borderWidth = 1
        self.titleLabel?.font = buttonFont
        self.setTitleColor(UIColor.white, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setSlateBlue() {
        self.setImage(nil, for: .normal)
        self.layer.borderColor = bgColor.cgColor
        self.layer.borderWidth = 1
        self.backgroundColor = bgColor
        self.setTitleColor(UIColor.white, for: .normal)
    }
    
    func setAsGreen() {
        self.setImage(nil, for: .normal)
        self.backgroundColor = greenColor
        self.layer.borderColor = greenColor.cgColor
        self.layer.borderWidth = 1
        self.setTitleColor(UIColor.white, for: .normal)
    }

}
