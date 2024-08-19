//
//  CityListModel.swift
//  WeatherApp
//
//  Created by N, Narasimhulu on 19/08/24.
//  Copyright © 2024 Narasimha. All rights reserved.
//


import Foundation

struct CityListModel : Codable {
    let id : Int?
    let name : String?
    let state : String?
    let country : String?
    let coord : Coord?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case state = "state"
        case country = "country"
        case coord = "coord"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        state = try values.decodeIfPresent(String.self, forKey: .state)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        coord = try values.decodeIfPresent(Coord.self, forKey: .coord)
    }
}
