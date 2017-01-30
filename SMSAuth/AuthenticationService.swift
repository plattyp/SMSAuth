//
//  AuthenticationService.swift
//  SMSAuth
//
//  Created by Andrew Platkin on 1/29/17.
//  Copyright © 2017 Andrew Platkin. All rights reserved.
//

import Foundation
import KeyClip
import Alamofire
import AlamofireObjectMapper

class AuthenticationService: BaseService {
    
    func baseAuthPath() -> String {
        do {
            return try baseApiPath() + "/auth"
        } catch {
            print("BASE API PATH not set properly")
        }
        return ""
    }
    
    func login(phoneNum: String, callback:@escaping (Bool, String?) -> Void) {
        let url = baseAuthPath() + "/login"
        
        let parameters = [
            "phone_number": phoneNum
        ]
        
        alamoFireManager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headersWithoutToken)
            .responseObject { (response: DataResponse<BaseResponse>) in
            
                if (response.result.error != nil) {
                    callback(false,  "Something went wrong")
                } else {
                    let (status, message) = self.parseBaseResponse(response: response.result.value)
                    callback(status, message)
                }
        }
    }
    
    func verifyPhone(verificationToken: String, phoneNum: String, callback:@escaping (Bool, String?, Int?, Bool?) -> Void) {
        let url = baseAuthPath() + "/verify"
        
        let parameters = [
            "phone_number": phoneNum,
            "verification_token": verificationToken
        ]
        
        alamoFireManager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headersWithoutToken)
            .responseObject { (response: DataResponse<AuthResponse>) in
                
                if (response.result.error != nil) {
                    callback(false,  "Something went wrong", nil, nil)
                } else {
                    let authResponse = response.result.value
                    
                    if let status = authResponse?.status {
                        if (status) {
                            // Save Token For Use Later
                            if let authToken = authResponse?.authenticationToken {
                                self.saveAuthenticationToken(authToken: authToken)
                            }
                            
                            // Return Back Other Attributes
                            var newUser = false
                            var userId = 0
                            if let unwrappedUserId = authResponse?.userId {
                                userId = unwrappedUserId
                            }
                            if let unwrappedNewUser = authResponse?.newUser {
                                newUser = unwrappedNewUser
                            }
                            callback(true, nil, userId, newUser)
                        } else {
                            if let message = authResponse?.message {
                                callback(false, message, nil, nil)
                            }
                        }
                    } else {
                        callback(false,  "Something went wrong", nil, nil)
                    }
                }
        }
    }
    
    func logout(callback: @escaping (Bool, String?) -> Void) {
        let url = baseAuthPath() + "/logout"
        
        alamoFireManager.request(url, method: .delete, encoding: JSONEncoding.default, headers: headersWithToken())
            .responseObject { (response: DataResponse<BaseResponse>) in
                
                if (response.result.error != nil) {
                    callback(false,  "Something went wrong")
                } else {
                    let (status, message) = self.parseBaseResponse(response: response.result.value)
                    callback(status, message)
                }
        }
    }
    
    private func saveAuthenticationToken(authToken: String) {
        _ = KeyClip.save("authentication_token", string: authToken)
    }
}
