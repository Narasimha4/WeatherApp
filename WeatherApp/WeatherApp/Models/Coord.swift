//
//  Coord.swift
//  WeatherApp
//
//  Created by N, Narasimhulu on 23/11/20.
//  Copyright © 2020 Narasimha. All rights reserved.
//

import Foundation
struct Coord : Codable {
    let lon : Double?
    let lat : Double?
    
    enum CodingKeys: String, CodingKey {
        
        case lon = "lon"
        case lat = "lat"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lon = try values.decodeIfPresent(Double.self, forKey: .lon)
        lat = try values.decodeIfPresent(Double.self, forKey: .lat)
    }
    
}
