//
//  Bikes.swift
//  Bicycall
//
//  Created by Fares Ben Slama on 28/12/2020.
//

import Foundation

class Bikes: Codable {
    
    var bike_id: Int
    var model:String
    var type: String
    var price: String
    var image: String
    var shop_id: Int
    var title: String
    
    
    init(id: Int ,model: String ,type:String ,price:String ,image:String , shop:Int, title:String ){
        self.bike_id = id
        self.model = model
        self.type = type
        self.price = price
        self.image = image
        self.shop_id = shop
        self.title = title
    }
    
    
}
