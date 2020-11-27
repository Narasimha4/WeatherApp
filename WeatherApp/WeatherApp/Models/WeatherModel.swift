//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by N, Narasimhulu on 23/11/20.
//  Copyright © 2020 Narasimha. All rights reserved.
//

import Foundation
struct WeatherModel : Codable {
	let cnt : Int?
	let list : [List]?

	enum CodingKeys: String, CodingKey {

		case cnt = "cnt"
		case list = "list"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		cnt = try values.decodeIfPresent(Int.self, forKey: .cnt)
		list = try values.decodeIfPresent([List].self, forKey: .list)
	}

}
