//
//  SMSAuth.swift
//  SMSAuth
//
//  Created by Andrew Platkin on 1/29/17.
//  Copyright © 2017 Andrew Platkin. All rights reserved.
//

import Foundation

public class SMSAuth {
    
    private static var apiPathKey: String = "sms_auth_api_path"
    
    public class func setApiPath(path: String) {
        UserDefaults.standard.setValue(path, forKey: apiPathKey)
    }
    
    class func apiPathDefined() -> Bool {
        return apiPath() != ""
    }
    
    class func apiPath() -> String {
        var path = ""
        if let unwrappedPath = UserDefaults.standard.string(forKey: apiPathKey) {
            path = unwrappedPath
        }
        return path
    }
}
