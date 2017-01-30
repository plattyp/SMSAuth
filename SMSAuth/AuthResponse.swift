//
//  AuthResponse.swift
//  SMSAuth
//
//  Created by Andrew Platkin on 1/29/17.
//  Copyright © 2017 Andrew Platkin. All rights reserved.
//

import Foundation
import ObjectMapper

class AuthResponse: BaseResponse {
    
    var authenticationToken: String?
    var userId: Int?
    var newUser: Bool?
    
    override func mapping(map: Map) {
        message <- map["message"]
        status <- map["status"]
        authenticationToken <- map["authentication_token"]
        userId <- map["user_id"]
        newUser <- map["new_user"]
    }
}

