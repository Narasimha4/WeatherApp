//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by N, Narasimhulu on 26/11/20.
//  Copyright © 2020 Narasimha. All rights reserved.
//

import UIKit

// MARK: - Default cities to load
enum Cities: Int {
    case London = 2643743
    case Paris = 2968815
}

class WeatherViewModel: NSObject {
    
    lazy var apiService: APIService = {
        return APIService()
    }()
    
    private var citiIdArray = [Int]()
    private var cityData: [CityListModel]?
    var bindVMToVC: ((WeatherModel?, Error?) -> Void)?
    
    override init() {
        super.init()
        
        cityData = JsonHelper.loadJson(fileName: WeatherConstants.Texts.jsonFileNmae)
        
        citiIdArray.append(Cities.London.rawValue)
        citiIdArray.append(Cities.Paris.rawValue)
        
        UserDefaults.standard.set(citiIdArray, forKey: WeatherConstants.userDefaults.updatedCitiesKey)
        
        getWeatherData()
    }
    
    // MARK: - Add new city at top of the list
    func addNewCity(name: String) -> [Int]? {
        guard let newCity = getCityIdByCityName(name: name.capitalized) else {
            return nil
        }
        if !citiIdArray.contains(newCity) {
            citiIdArray.insert(newCity, at: 0)
            UserDefaults.standard.set(citiIdArray, forKey: WeatherConstants.userDefaults.updatedCitiesKey)
        }
        getWeatherData()
        
        return citiIdArray
    }
    
    // MARK: - API call to get weather data
    func getWeatherData() {
        
        if let updatedCities = UserDefaults.standard.value(forKey: WeatherConstants.userDefaults.updatedCitiesKey) as? [Int] {
            apiService.getWeatherAPI(parameter: [WeatherConstants.API.idParameterKey : updatedCities], completion: { [weak self] (weatherData, error)  in
                self?.bindVMToVC?(weatherData, error)
            })
        }
    }
    
    // MARK: - Fetch CityId from city name
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

