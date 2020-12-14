//
//  Rent.swift
//  Bicycall
//
//  Created by Fares Ben Slama on 14/12/2020.
//

import Foundation

class Rent {
    
    var location_id: Int
    var datelocation:String
    var adresselocation: String
    var user_id: Int
    var bike_id: Int
    var model: String
    var type: String
    var price: String
    var image: String
    var hours: String
    var totalprice: String
    
    
    init(id: Int ,date: String , adresse: String , user: Int , bike: Int , model: String ,type:String ,price:String ,image:String , hours: String , totalprice: String ){
        self.location_id = id
        self.datelocation = date
        self.adresselocation = adresse
        self.model = model
        self.user_id = user
        self.bike_id = bike
        self.type = type
        self.price = price
        self.image = image
        self.hours = hours
        self.totalprice = totalprice
    }
    
    
    
    
}

