//
//  SMSAuth.swift
//  SMSAuth
//
//  Created by Andrew Platkin on 1/29/17.
//  Copyright © 2017 Andrew Platkin. All rights reserved.
//

import Foundation
import KeyClip

public class SMSAuth {
    
    private static var apiPathKey: String = "sms_auth_api_path"
    
    public class func setApiPath(path: String) {
        UserDefaults.standard.setValue(path, forKey: apiPathKey)
    }
    
    public class func showViewController(window: UIWindow?, authenticateViewController: UIViewController, loginViewController: LoginViewController) {
        if isAuthenticated() {
            window?.rootViewController = UINavigationController(rootViewController: authenticateViewController)
        } else {
            window?.rootViewController = UINavigationController(rootViewController: loginViewController)
        }
        
        window?.makeKeyAndVisible()
    }
    
    public class func isAuthenticated() -> Bool {
        return KeyClip.exists(Config.values.tokenKey)
    }
    
    public class func authenticationToken() -> String {
        if let token = KeyClip.load(Config.values.tokenKey) as String? {
            return token
        }
        return ""
    }
    
    public class func logout(callback: @escaping (Bool, String) -> Void) {
        AuthenticationService().logout(callback: callback)
    }
    
    public class func revertToLogin() {
        OperationQueue.main.addOperation {
            let currentVC = UIApplication.shared.keyWindow?.rootViewController
            currentVC?.dismiss(animated: true, completion: nil)
            UIApplication.shared.keyWindow?.rootViewController = LoginViewController()
        }
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
