//
//  Cyclist.swift
//  Bicycall
//
//  Created by Jamil Joo on 8/1/2021.
//

import Foundation

class Cyclist: Codable {
    var cyclist_id: Int
    var title: String
    var latitude: Double
    var longitude: Double
    
    init(id: Int ,title: String ,latitude:Double ,longitude:Double ){
        self.cyclist_id = id
        self.title = title
        self.latitude = latitude
        self.longitude = longitude
    
    }
}
