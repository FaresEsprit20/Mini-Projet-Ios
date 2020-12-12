//
//  ConnectedUser.swift
//  Bicycall
//
//  Created by Fares Ben Slama on 12/12/2020.
//

import Foundation

class ConnectedUser {
    
    var user_id: Int?
    var name:String?
    var lastname: String?
    var email: String?
    var password: String?
    var phone: String?
    
    init(id: Int? = nil,email: String? = nil ,password:String? = nil ,name:String? = nil ,lastname:String? = nil ,phone:String? = nil ){
        self.user_id = id
        self.email = email
        self.password = password
        self.name = name
        self.lastname = lastname
        self.phone = phone
    }
    
}
