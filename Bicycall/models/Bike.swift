//
//  Bike.swift
//  Bicycall
//
//  Created by Fares Ben Slama on 13/12/2020.
//

import Foundation

class Bike: Codable {
    
    var bike_id: Int
    var model:String
    var type: String
    var price: String
    var image: String
    
    
    init(id: Int ,model: String ,type:String ,price:String ,image:String ){
        self.bike_id = id
        self.model = model
        self.type = type
        self.price = price
        self.image = image
    }
    
    
}
