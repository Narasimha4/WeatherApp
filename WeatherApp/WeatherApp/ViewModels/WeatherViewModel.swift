//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by N, Narasimhulu on 26/11/20.
//  Copyright © 2020 Narasimha. All rights reserved.
//

import UIKit

enum Cities: String {
    case London
    case Paris
}

class WeatherViewModel: NSObject {
    
    var cityData: [CityListModel]?
    private var apiService: APIService!
    private(set) var weatherData: WeatherModel! {
        didSet {
            self.bindVMToVC()
        }
    }
    
    var citiIdArray = [Int]()
    
    var bindVMToVC: (() -> ()) = {}
    
    override init() {
        super.init()
        
        cityData = JsonHelper.loadJson(fileName: "city.list")
        
        guard let london = getCityIdByCityName(name: Cities.London.rawValue),
            let paris = getCityIdByCityName(name: Cities.Paris.rawValue) else {
                return
        }
        
        citiIdArray.append(london)
        citiIdArray.append(paris)
        
        getWeatherData()
    }
    
    func addNewCity(name: String) -> [Int]? {
        guard let newCity = getCityIdByCityName(name: name.capitalized) else {
            return nil
        }
        if !citiIdArray.contains(newCity) {
            citiIdArray.insert(newCity, at: 0)
        }
        getWeatherData()
        
        return citiIdArray
    }
    
    func getWeatherData() {
        apiService = APIService()
        apiService.makeNetworkCall(parameter: ["id" : citiIdArray], completion: { (weatherData) in
            self.weatherData = weatherData
        })
    }
    
    func getCityIdByCityName(name: String) -> Int? {
        if let cityDataList = cityData {
            for city in cityDataList {
                if city.name == name {
                    return city.id
                }
            }
        }
        return nil
    }
}

