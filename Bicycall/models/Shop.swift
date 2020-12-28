//
//  Shop.swift
//  Bicycall
//
//  Created by Fares Ben Slama on 28/12/2020.
//

import Foundation


class Shop {
    
    var shop_id: Int
    var title:String
    var latitude: Double
    var longitude: Double
   
    
    init(id: Int ,title: String , latitude: Double , longitude: Double ){
        self.shop_id = id
        self.title = title
        self.latitude = latitude
        self.longitude = longitude
    }
    
    
    
    
}

