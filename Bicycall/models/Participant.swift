//
//  Participant.swift
//  Bicycall
//
//  Created by Fares Ben Slama on 10/1/2021.
//

import Foundation

class Participant: Codable {
    
    var puser_id : Int
    var pevent_id: Int
    var user_id: Int
    var name:String
    var lastname: String
    var email: String
    var password: String
    var phone: String
    
    
    init(puser_id:Int, pevent_id: Int, userid:Int, email:String, password:String, name:String, lastname:String, phone:String ) {
        
        self.puser_id = puser_id
        self.pevent_id = pevent_id
        self.user_id = userid
        self.email = email
        self.password = password
        self.name = name
        self.lastname = lastname
        self.phone = phone
        
    }

    
    
    
    
}
