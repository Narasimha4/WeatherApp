//
//  JsonHelper.swift
//  WeatherApp
//
//  Created by N, Narasimhulu on 19/08/24.
//  Copyright © 2024 Narasimha. All rights reserved.
//

import UIKit

class JsonHelper {
    
    // MARK: - Get data object from JSON file
    static func loadJson(fileName: String) -> [CityListModel]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: WeatherConstants.Texts.jsonFileType) {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                // Serialize the data into an Object
                let jsonData = try decoder.decode([CityListModel].self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
