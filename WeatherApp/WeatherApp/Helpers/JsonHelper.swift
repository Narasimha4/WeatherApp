//
//  JsonHelper.swift
//  WeatherApp
//
//  Created by N, Narasimhulu on 27/11/20.
//  Copyright © 2020 Narasimha. All rights reserved.
//

import UIKit

class JsonHelper {
    static func loadJson(fileName: String) -> [CityListModel]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([CityListModel].self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
