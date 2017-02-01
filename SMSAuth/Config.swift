//
//  Config.swift
//  SMSAuth
//
//  Created by Andrew Platkin on 1/30/17.
//  Copyright © 2017 Andrew Platkin. All rights reserved.
//

import Foundation

class Config {
    
    class color {
        
        // Blue Colors
        
        // HEX #3B5998
        class var blue: UIColor {
            return UIColor(red: 59/255, green: 89/255, blue: 152/255, alpha: 1)
        }
        
        // HEX #546979
        class var slateBlue: UIColor {
            return UIColor(red: 84/255, green: 105/255, blue: 121/255, alpha: 1)
        }
        
        // HEX #48A0DC
        class var skyBlue: UIColor {
            return UIColor(red: 72/255, green: 160/255, blue: 220/255, alpha: 1)
        }
        
        // HEX #38454F
        class var darkerBlue: UIColor {
            return UIColor(red: 56/255, green: 69/255, blue: 79/255, alpha: 1)
        }
        
        // HEX #47A0DB
        class var mainBlue: UIColor {
            return UIColor(red: 71/255, green: 160/255, blue: 219/255, alpha: 1)
        }
        
        // HEX #4B94C4
        class var darkBlue: UIColor {
            return UIColor(red: 75/255, green: 148/255, blue: 196/255, alpha: 1)
        }
        
        // HEX #3B5998
        class var facebookBlue: UIColor {
            return UIColor(red: 59/255, green: 89/255, blue: 152/255, alpha: 1)
        }
        
        // Gray
        
        // HEX #DEE1E4
        class var lightGray: UIColor {
            return UIColor(red: 222/255, green: 225/255, blue: 228/255, alpha: 1)
        }
        
        // HEX #F3F3F3
        class var lightGray2: UIColor {
            return UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1)
        }
        
        // HEX #DADFDE
        class var lightGray3: UIColor {
            return UIColor(red: 218/255, green: 223/255, blue: 222/255, alpha: 1)
        }
        
        // HEX #CCCCCC
        class var lightGray4: UIColor {
            return UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
        }
        
        // HEX #A6AFB6
        class var lightGray5: UIColor {
            return UIColor(red: 166/255, green: 175/255, blue: 182/255, alpha: 1)
        }
        
        // HEX #D6D6D6
        class var darkGray: UIColor {
            return UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1)
        }
        
        // HEX #AAAAAA
        class var darkGray2: UIColor {
            return UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)
        }
        
        // HEX #333333
        class var darkGray3: UIColor {
            return UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        }
        
        // HEX #2D3237
        class var darkGray4: UIColor {
            return UIColor(red: 45/255, green: 50/255, blue: 55/255, alpha: 1)
        }
        
        // Green
        
        // HEX #88C057
        class var limeGreen: UIColor {
            return UIColor(red: 136/255, green: 192/255, blue: 87/255, alpha: 1)
        }
        
        // Red
        
        // HEX #ED7161
        class var red: UIColor {
            return UIColor(red: 237/255, green: 113/255, blue: 97/255, alpha: 1)
        }
        
        // Black
        
        // HEX #151B20
        class var black1: UIColor {
            return UIColor(red: 21/255, green: 27/255, blue: 32/255, alpha: 1)
        }
        
        // Orange
        
        // HEX #D69D43
        class var darkOrange: UIColor {
            return UIColor(red: 214/255, green: 157/255, blue: 67/255, alpha: 1)
        }
    }
    
    class font {
        
        // Open Sans
        class var openSansRegular10: UIFont {
            return UIFont.init(name: "OpenSans", size: 10)!
        }
        
        class var openSansRegular12: UIFont {
            return UIFont.init(name: "OpenSans", size: 12)!
        }
        
        class var openSansRegular14: UIFont {
            return UIFont.init(name: "OpenSans", size: 14)!
        }
        
        class var openSansRegular16: UIFont {
            return UIFont.init(name: "OpenSans", size: 16)!
        }
        
        class var openSansRegular20: UIFont {
            return UIFont.init(name: "OpenSans", size: 20)!
        }
        
        class var openSansRegular26: UIFont {
            return UIFont.init(name: "OpenSans", size: 26)!
        }
        
        class var openSansSemibold12: UIFont {
            return UIFont.init(name: "OpenSans-Semibold", size: 12)!
        }
        
        class var openSansSemibold14: UIFont {
            return UIFont.init(name: "OpenSans-Semibold", size: 14)!
        }
        
        class var openSansSemibold16: UIFont {
            return UIFont.init(name: "OpenSans-Semibold", size: 16)!
        }
        
        class var openSansSemibold20: UIFont {
            return UIFont.init(name: "OpenSans-Semibold", size: 20)!
        }
        
        class var openSansSemibold26: UIFont {
            return UIFont.init(name: "OpenSans-Semibold", size: 26)!
        }
        
        class var openSansLight12: UIFont {
            return UIFont.init(name: "OpenSans-Light", size: 12)!
        }
        
        class var openSansLight16: UIFont {
            return UIFont.init(name: "OpenSans-Light", size: 16)!
        }
        
        class var openSansLight32: UIFont {
            return UIFont.init(name: "OpenSans-Light", size: 32)!
        }
        
        class var openSansLight40: UIFont {
            return UIFont.init(name: "OpenSans-Light", size: 40)!
        }
        
        class var openSansItalic12: UIFont {
            return UIFont.init(name: "OpenSans-Italic", size: 12)!
        }
    }
}
