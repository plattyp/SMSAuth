//
//  BaseResponse.swift
//  SMSAuth
//
//  Created by Andrew Platkin on 1/29/17.
//  Copyright © 2017 Andrew Platkin. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseResponse: Mappable {
    
    var message: String?
    var status: Bool?
    
    init() {
        
    }
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        message <- map["message"]
        status <- map["status"]
    }
}
