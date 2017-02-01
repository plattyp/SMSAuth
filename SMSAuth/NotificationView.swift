//
//  NotificationView.swift
//  SMSAuth
//
//  Created by Andrew Platkin on 1/31/17.
//  Copyright © 2017 Andrew Platkin. All rights reserved.
//

import UIKit

class NotificationView: UIView {

    // Constants
    let greenBackgroundColor = Config.color.limeGreen
    let redBackgroundColor = Config.color.red
    let blueBackgroundColor = Config.color.slateBlue
    let fontToUse: UIFont = UIFont.systemFont(ofSize: 12.0)
    
    // Dynamic Controls
    var view = UIView()
    let messageLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        view = UIView(frame: frame)
        self.addSubview(view)
        
        // Constrain View
        view.translatesAutoresizingMaskIntoConstraints = false
        let topView = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let bottomView = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        let leftView = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0)
        let rightView = NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([topView, bottomView, leftView, rightView])
        
        // Add Label
        messageLabel.font = fontToUse
        messageLabel.numberOfLines = 2
        messageLabel.adjustsFontSizeToFitWidth = true
        messageLabel.textColor = UIColor.white
        view.addSubview(messageLabel)
        
        // Constrain Label
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        let middleVertical = NSLayoutConstraint(item: messageLabel, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: messageLabel, attribute: .width, relatedBy: .lessThanOrEqual, toItem: self.view, attribute: .width, multiplier: 4/5, constant: 0)
        let leadingMargin = NSLayoutConstraint(item: messageLabel, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leadingMargin, multiplier: 1, constant: 10)
        NSLayoutConstraint.activate([middleVertical,leadingMargin, width])
        
//        // Add an X top right to simulate closing
//        let crossImageView = UIImageView(image: Config.image.CrossIcon)
//        view.addSubview(crossImageView)
//        
//        // Constrain Cross
//        crossImageView.translatesAutoresizingMaskIntoConstraints = false
//        let aspectRatio = NSLayoutConstraint(item: crossImageView, attribute: .height, relatedBy: .equal, toItem: crossImageView, attribute: .width, multiplier: 1, constant: 0)
//        let widthCross = NSLayoutConstraint(item: crossImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20)
//        let topCross = NSLayoutConstraint(item: crossImageView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 10)
//        let trailingMargin = NSLayoutConstraint(item: crossImageView, attribute: .trailingMargin, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -15)
//        NSLayoutConstraint.activate([aspectRatio, widthCross, topCross, trailingMargin])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // Methods
    func setAsRed() {
        view.backgroundColor = redBackgroundColor
    }
    
    func setAsGreen() {
        view.backgroundColor = greenBackgroundColor
    }
    
    func setAsBlue() {
        view.backgroundColor = blueBackgroundColor
    }

}
