//
//  BaseService.swift
//  SMSAuth
//
//  Created by Andrew Platkin on 1/29/17.
//  Copyright © 2017 Andrew Platkin. All rights reserved.
//

import Foundation
import Alamofire
import KeyClip

public class SMSAuthBaseService {
    
    let headersWithoutToken = [
        "Accept": "application/json",
        "Content-Type": "application/json"
    ]
    
    var alamoFireManager = Alamofire.SessionManager.default
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15 // seconds
        configuration.timeoutIntervalForResource = 15
        self.alamoFireManager = Alamofire.SessionManager(configuration: configuration)
    }

    func baseApiPath() throws -> String {
        if !SMSAuth.apiPathDefined() {
            throw SMSAuthError.apiPathNotDefined
        }
        return SMSAuth.apiPath()
    }
    
    func headersWithToken() -> [String:String] {
        var headers = headersWithoutToken
        headers["Authorization"] = getAuthenticationToken()
        return headers
    }
    
    func isAuthenticated() -> Bool {
        return SMSAuth.isAuthenticated()
    }
    
    func getAuthenticationToken() -> String {
        return SMSAuth.authenticationToken()
    }
    
    func removeAuthenticationToken() {
        _ = KeyClip.delete(Config.values.tokenKey)
    }
    
    func parseBaseResponse(response: BaseResponse?) -> (Bool, String) {
        if let success = response?.success {
            if (success) {
                return (true, "")
            } else {
                if let message = response?.message {
                    return (false, message)
                }
            }
        }
        
        return (false,  "Something went wrong")
    }
}
