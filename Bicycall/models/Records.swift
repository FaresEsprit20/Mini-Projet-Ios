//
//  Records.swift
//  Bicycall
//
//  Created by Fares Ben Slama on 28/12/2020.
//

import Foundation

//
//  Record.swift
//  Bicycall
//
//  Created by Fares Ben Slama on 28/12/2020.
//

import Foundation

class Records {
    
    var record_id: Int
    var address:String
    var time:String
    var distance: String
    var daterecord: String
    var user_id: String
    
    
    init(id: Int ,address: String ,time:String ,distance:String ,date:String , user:String ){
        self.record_id = id
        self.address = address
        self.time = time
        self.distance = distance
        self.daterecord = date
        self.user_id = user
    }
    
    
    
    
}

