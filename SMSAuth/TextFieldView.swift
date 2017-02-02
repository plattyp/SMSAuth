//
//  TextFieldView.swift
//  SMSAuth
//
//  Created by Andrew Platkin on 1/30/17.
//  Copyright © 2017 Andrew Platkin. All rights reserved.
//

import UIKit

class TextFieldView: UITextField {
    
    // Constants
    let inputTextColor: UIColor = Config.color.slateBlue
    let inputFont: UIFont = UIFont.systemFont(ofSize: 16.0)
    let validationColor: UIColor = Config.color.red
    let readOnlyBackgroundColor: UIColor = Config.color.lightGray
    
    // Variables
    var validatePhoneNum: Bool = false
    var isRequired: Bool = false
    var characterLimit: Int = 10
    
    init(placeholderText: String, isRequired: Bool, isPhoneNum: Bool, useNumberPad: Bool) {
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        configureTextField()
        
        // Setup Masking
        if (isPhoneNum) {
            self.validatePhoneNum = true
        }
        
        // Setup Keyboard
        if (useNumberPad) {
            self.keyboardType = .numberPad
        }
        
        
        // Set As Requied
        self.isRequired = isRequired
        if isRequired {
            self.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingDidEnd)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureTextField()
    }
    
    func configureTextField() {
        self.layer.cornerRadius = 5.0
        self.backgroundColor = UIColor.white
        self.textColor = inputTextColor
        self.font = inputFont
        
        // Add Left Padding
        let screenWidth = UIScreen.main.bounds.width
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth * 0.04, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
        
        // Add Generic Done Button
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(UIView.endEditing(_:)))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        self.inputAccessoryView = keyboardToolbar
    }
    
    func textFieldDidChange(textField: UITextField) {
        _ = validatePresence()
    }

    // Revert To Valid
    func revertAsNew() {
        self.text = nil
        self.backgroundColor = UIColor.white
    }
    
    // Validation If Required
    func validatePresence() -> Bool {
        if (self.text == "") {
            self.backgroundColor = validationColor
            return false
        } else {
            if self.validatePhoneNum {
                if ((self.text?.characters.count)! >= 10) {
                    self.backgroundColor = UIColor.white
                    return true
                } else {
                    self.backgroundColor = validationColor
                    return false
                }
            } else {
                self.backgroundColor = UIColor.white
                return true
            }
        }
    }
}
