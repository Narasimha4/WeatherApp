//
//  Sys.swift
//  WeatherApp
//
//  Created by N, Narasimhulu on 23/11/20.
//  Copyright © 2020 Narasimha. All rights reserved.
//

import Foundation
struct Sys : Codable {
	let country : String?
	let timezone : Int?
	let sunrise : Int?
	let sunset : Int?

	enum CodingKeys: String, CodingKey {

		case country = "country"
		case timezone = "timezone"
		case sunrise = "sunrise"
		case sunset = "sunset"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		country = try values.decodeIfPresent(String.self, forKey: .country)
		timezone = try values.decodeIfPresent(Int.self, forKey: .timezone)
		sunrise = try values.decodeIfPresent(Int.self, forKey: .sunrise)
		sunset = try values.decodeIfPresent(Int.self, forKey: .sunset)
	}

}
