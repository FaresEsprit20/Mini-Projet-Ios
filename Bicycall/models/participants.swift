//
//  participants.swift
//  Bicycall
//
//  Created by Jamil Joo on 8/1/2021.
//

import Foundation

class participants: Codable {
    var puser_id : Int
    var pevent_id: Int
    
    init(puser_id:Int, pevent_id: Int ) {
        
        self.puser_id = puser_id
        self.pevent_id = pevent_id
        
    }
}
