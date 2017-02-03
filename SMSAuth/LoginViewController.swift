//
//  LoginViewController.swift
//  SMSAuth
//
//  Created by Andrew Platkin on 1/30/17.
//  Copyright © 2017 Andrew Platkin. All rights reserved.
//

import UIKit
import SwiftOverlays
import BetterBaseClasses
import Font_Awesome_Swift

public protocol LoginViewDelegate {
    func onLoginSuccess(userId: Int, newUser: Bool)
}
public class LoginViewController: BaseViewController, UITextFieldDelegate {

    // Constants
    var bgColor = Config.color.lightGray2
    var textFont = UIFont.systemFont(ofSize: 16.0)
    var textColor = Config.color.slateBlue
    var closeColor = Config.color.slateBlue
    var closeFont = UIFont.systemFont(ofSize: 12.0)
    
    // Services
    let authService: AuthenticationService = AuthenticationService()

    // Dynamic Controls
    var mainTextLabel: UILabel = UILabel(frame: CGRect.zero)
    var mainActionButton: SquaredButton = SquaredButton()
    var mainInput: TextFieldView = TextFieldView(placeholderText: "Phone Number", isRequired: true, isPhoneNum: true, useNumberPad: true)
    var verificationInput: TextFieldView = TextFieldView(placeholderText: "Verification Code", isRequired: true, isPhoneNum: false, useNumberPad: true)
    var backButton: SquaredButton = SquaredButton()
    var verifyButton: SquaredButton = SquaredButton()
    
    // Variables
    public var delegate: LoginViewDelegate?
    public var phoneSubmitButtonText = "SEND"
    public var verificationCodeLimit = 6
    public var phoneInputEmptyText = "(312) 555-5555"
    public var phoneNumberInstruction = "Enter your phone number and we will send you a secure verification code"
    public var verifyEmptyText = "Verification Code"
    public var verifyInstruction = "Please enter your SMS verification code"
    public var verifySubmitButtonText = "LOGIN"
    public var closeable: Bool = false
    var phoneNumber: String?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        // End Editing When Tapping Outside Input
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        self.view.addGestureRecognizer(tap)
        
        setupView()
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupView() {
        self.view.backgroundColor = bgColor
        
        // Setup Delegation
        mainInput.delegate = self
        verificationInput.delegate = self
        
        // Setup Navigation
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.view.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.isTranslucent = true
        
        // Allow the view to be closed
        if closeable {
            let rightBarButton = UIBarButtonItem()
            rightBarButton.target = self
            rightBarButton.action = #selector(onClose)
            rightBarButton.tintColor = closeColor
            rightBarButton.setFAIcon(icon: .FATimes, iconSize: 30)
            self.navigationItem.setRightBarButton(rightBarButton, animated: true)
        }
        
        // Add Main Text Label
        mainTextLabel.font = textFont
        mainTextLabel.tintColor = textColor
        mainTextLabel.text = phoneNumberInstruction
        mainTextLabel.numberOfLines = 3
        mainTextLabel.lineBreakMode = .byWordWrapping
        mainTextLabel.adjustsFontSizeToFitWidth = true
        mainTextLabel.textAlignment = .center
        self.view.addSubview(mainTextLabel)
        
        // Constrain Main Text Label
        mainTextLabel.translatesAutoresizingMaskIntoConstraints = false
        let centerXTextLabel = NSLayoutConstraint(item: mainTextLabel, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
        let centerYTextLabel = NSLayoutConstraint(item: mainTextLabel, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 0.55, constant: 0)
        let widthTextLabel = NSLayoutConstraint(item: mainTextLabel, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.90, constant: 0)
        NSLayoutConstraint.activate([centerXTextLabel, centerYTextLabel, widthTextLabel])
        
        // Add Phone Input
        mainInput.placeholder = phoneInputEmptyText
        self.view.addSubview(mainInput)
        
        // Constrain Phone Input
        mainInput.translatesAutoresizingMaskIntoConstraints = false
        let centerXPhoneInput = NSLayoutConstraint(item: mainInput, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
        let topPhoneInput = NSLayoutConstraint(item: mainInput, attribute: .top, relatedBy: .equal, toItem: mainTextLabel, attribute: .bottom, multiplier: 1, constant: 20)
        let widthPhoneInput = NSLayoutConstraint(item: mainInput, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.90, constant: 0)
        let heightPhoneInput = NSLayoutConstraint(item: mainInput, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)
        NSLayoutConstraint.activate([centerXPhoneInput, topPhoneInput, widthPhoneInput, heightPhoneInput])
        
        // Add Main Button
        mainActionButton = SquaredButton(frame: CGRect.zero, text: phoneSubmitButtonText)
        mainActionButton.setSlateBlue()
        mainActionButton.addTarget(self, action: #selector(onPhoneSubmit), for: .touchUpInside)
        self.view.addSubview(mainActionButton)
        
        // Constrain Main Button
        mainActionButton.translatesAutoresizingMaskIntoConstraints = false
        let centerXMainActionButton = NSLayoutConstraint(item: mainActionButton, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
        let widthMainActionButton = NSLayoutConstraint(item: mainActionButton, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.90, constant: 0)
        let heightMainActionButton = NSLayoutConstraint(item: mainActionButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute , multiplier: 1, constant: 75)
        let topMainActionButton = NSLayoutConstraint(item: mainActionButton, attribute: .top, relatedBy: .equal, toItem: mainInput, attribute: .bottom, multiplier: 1, constant: 20)
        NSLayoutConstraint.activate([centerXMainActionButton, widthMainActionButton, heightMainActionButton, topMainActionButton])
        
        // Add Verification Input
        verificationInput.characterLimit = verificationCodeLimit
        verificationInput.placeholder = verifyEmptyText
        verificationInput.isHidden = true
        self.view.addSubview(verificationInput)
        
        // Constrain Phone Input
        verificationInput.translatesAutoresizingMaskIntoConstraints = false
        let centerXVerifyInput = NSLayoutConstraint(item: verificationInput, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
        let topVerifyInput = NSLayoutConstraint(item: verificationInput, attribute: .top, relatedBy: .equal, toItem: mainTextLabel, attribute: .bottom, multiplier: 1, constant: 20)
        let widthVerifyInput = NSLayoutConstraint(item: verificationInput, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.90, constant: 0)
        let heightVerifyInput = NSLayoutConstraint(item: verificationInput, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)
        NSLayoutConstraint.activate([centerXVerifyInput, topVerifyInput, widthVerifyInput, heightVerifyInput])
        
        //// Setup Verification Buttons
        
        // Add Back Button
        backButton = SquaredButton(frame: CGRect.zero, text: "BACK")
        backButton.setSlateBlue()
        backButton.addTarget(self, action: #selector(onBackSelected), for: .touchUpInside)
        backButton.isHidden = true
        self.view.addSubview(backButton)
        
        // Add Verify Button
        verifyButton = SquaredButton(frame: CGRect.zero, text: verifySubmitButtonText)
        verifyButton.setAsGreen()
        verifyButton.addTarget(self, action: #selector(onVerifySelected), for: .touchUpInside)
        verifyButton.isHidden = true
        self.view.addSubview(verifyButton)
        
        // Constrain Buttons
        backButton.translatesAutoresizingMaskIntoConstraints = false
        let topBackButton = NSLayoutConstraint(item: backButton, attribute: .top, relatedBy: .equal, toItem: mainInput, attribute: .bottom, multiplier: 1, constant: 20)
        let heightBackButton = NSLayoutConstraint(item: backButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 75)
        let leftBackButton = NSLayoutConstraint(item: backButton, attribute: .left, relatedBy: .equal, toItem: verificationInput, attribute: .left, multiplier: 1, constant: 0)
        let widthBackButton = NSLayoutConstraint(item: backButton, attribute: .width, relatedBy: .equal, toItem: verificationInput, attribute: .width, multiplier: 0.47, constant: 0)
        NSLayoutConstraint.activate([topBackButton, heightBackButton, leftBackButton, widthBackButton])
        
        verifyButton.translatesAutoresizingMaskIntoConstraints = false
        let topVerifyButton = NSLayoutConstraint(item: verifyButton, attribute: .top, relatedBy: .equal, toItem: mainInput, attribute: .bottom, multiplier: 1, constant: 20)
        let heightVerifyButton = NSLayoutConstraint(item: verifyButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 75)
        let rightVerifyButton = NSLayoutConstraint(item: verifyButton, attribute: .right, relatedBy: .equal, toItem: verificationInput, attribute: .right, multiplier: 1, constant: 0)
        let widthVerifyButton = NSLayoutConstraint(item: verifyButton, attribute: .width, relatedBy: .equal, toItem: verificationInput, attribute: .width, multiplier: 0.47, constant: 0)
        NSLayoutConstraint.activate([topVerifyButton, heightVerifyButton, rightVerifyButton, widthVerifyButton])
    }
    
    func onClose() {
        OperationQueue.main.addOperation {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func onPhoneSubmit() {
        if mainInput.validatePresence() {
            if let phoneNum = mainInput.text {
                loginWithPhoneNum(phoneNum: phoneNum)
            }
        }
    }
    
    func loginWithPhoneNum(phoneNum: String) {
        SwiftOverlays.showBlockingWaitOverlayWithText("Submitting..")
        self.authService.login(phoneNum: phoneNum, callback: {
            (status, errorMsg) -> Void in
            
            // Kill Overlay
            SwiftOverlays.removeAllBlockingOverlays()
            
            // Report Status
            if (!status) {
                self.showError(errorMessage: errorMsg)
            } else {
                self.switchToVerificationMode(phoneNum: phoneNum)
            }
            
        })
    }
    
    func switchToVerificationMode(phoneNum: String) {
        // Save Phone Number
        self.phoneNumber = phoneNum
        
        // Switch Text
        self.mainTextLabel.text = verifyInstruction

        // Switch Input
        self.mainInput.isHidden = true
        self.verificationInput.isHidden = false
        
        // Clear Input Cache
        self.verificationInput.revertAsNew()
        
        // Switch Submit Buttons
        self.mainActionButton.isHidden = true
        self.backButton.isHidden = false
        self.verifyButton.isHidden = false
    }
    
    func onBackSelected() {
        // Switch Text
        self.mainTextLabel.text = phoneNumberInstruction
        
        // Switch Input
        self.mainInput.isHidden = false
        self.verificationInput.isHidden = true
        
        // Switch Submit Buttons
        self.mainActionButton.isHidden = false
        self.backButton.isHidden = true
        self.verifyButton.isHidden = true
    }
    
    func onVerifySelected() {
        if let phoneNumber = self.phoneNumber {
            if let verificationToken = verificationInput.text {
                SwiftOverlays.showBlockingWaitOverlayWithText("Verifying..")
                authService.verifyPhone(verificationToken: verificationToken, phoneNum: phoneNumber, callback: {
                    (success, errorMsg, userId, newUser) -> Void in
                    
                    // Kill Overlay
                    SwiftOverlays.removeAllBlockingOverlays()
                    
                    if (success) {
                        self.showSuccessMessage(successMessage: "Successfully logged in")
                        self.delegate?.onLoginSuccess(userId: userId, newUser: newUser)
                    } else {
                        self.showError(errorMessage: errorMsg)
                    }
                })
            }
        }
    }
    
    // Top Notification Overlays
    func showError(errorMessage: String) {
        OperationQueue.main.addOperation {
            // Remove Existing Overlays
            self.removeAllOverlays()
            
            //Load Notification View
            let notificationView = NotificationView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.frame.height * 0.0975))
            
            //Customize the notification
            notificationView.setAsRed()
            notificationView.messageLabel.text = errorMessage
            
            //Call the notification status bar
            UIViewController.showNotificationOnTopOfStatusBar(notificationView, duration: 4)
        }
    }
    
    func showSuccessMessage(successMessage: String) {
        OperationQueue.main.addOperation {
            // Remove Existing Overlays
            self.removeAllOverlays()
            
            //Load Notification View
            let notificationView = NotificationView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.frame.height * 0.0975))
            
            //Customize the notification
            notificationView.setAsGreen()
            notificationView.messageLabel.text = successMessage
            
            //Call the notification status bar
            UIViewController.showNotificationOnTopOfStatusBar(notificationView, duration: 4)
        }
    }
    
    // Hide on keyboard return
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    // Hide keyboard on external touch
    func endEditing() {
        self.view.endEditing(true)
    }
    
    // Format the Phone Number as inputted
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let field: TextFieldView = textField as! TextFieldView
        if (field.validatePhoneNum) {
            if let currentText = field.text {
                let newString = (currentText as NSString).replacingCharacters(in: range, with: string)
                let components = newString.components(separatedBy: CharacterSet.decimalDigits.inverted)
                
                let decimalString = components.joined(separator: "") as NSString
                let length = decimalString.length
                let hasLeadingOne = length > 0 && decimalString.character(at: 0) == (1 as unichar)
                
                if length == 0 || (length > 10 && !hasLeadingOne) || length > 11
                {
                    let newLength = (currentText as NSString).length + (string as NSString).length - range.length as Int
                    
                    return (newLength > 10) ? false : true
                }
                var index: Int = 0
                let formattedString = NSMutableString()
                
                if hasLeadingOne
                {
                    formattedString.append("1 ")
                    index += 1
                }
                if (length - index) > 3
                {
                    let areaCode = decimalString.substring(with: NSMakeRange(index, 3))
                    formattedString.appendFormat("(%@) ", areaCode)
                    index += 3
                }
                if length - index > 3
                {
                    let prefix = decimalString.substring(with: NSMakeRange(index, 3))
                    formattedString.appendFormat("%@-", prefix)
                    index += 3
                }
                
                let remainder = decimalString.substring(from: index)
                formattedString.append(remainder)
                textField.text = formattedString as String
                return false
            }
        } else {
            if ((field.text?.characters.count)! >= field.characterLimit && range.length == 0) {
                return false
            } else {
                return true
            }
        }
        return true
    }

}
