//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by N, Narasimhulu on 19/08/24.
//  Copyright © 2024 Narasimha. All rights reserved.
//

import UIKit

// MARK: - Default cities to load
enum Cities: Int {
    // Keeping the open weather city ids for London and Paris
    case London = 2643743
    case Paris = 2968815
}

class WeatherViewModel: NSObject {
    
    // Create api service object
    lazy var apiService: APIService = {
        return APIService()
    }()
    
    // Create temporary cities array to send API city id parameters
    private var citiIdArray = [Int]()
    
    // Create Open weather city lists object
    private var cityData: [CityListModel]?
    
    // closure to bind view model to view controller
    // which returns weather model and error object
    var bindVMToVC: ((WeatherModel?, Error?) -> Void)?
    
    override init() {
        super.init()
        
        // Load the open weather local json to get city IDs
        cityData = JsonHelper.loadJson(fileName: WeatherConstants.Texts.jsonFileNmae)
        
        // get weather API call
        getWeatherData()
    }
    
    // MARK: - Add new city at top of the list
    func addNewCity(name: String) -> [Int]? {
        guard let newCity = getCityIdByCityName(name: name.capitalized) else {
            // Returing nil, if city name not matched in the json
            return nil
        }
        
        // Temporarily storing the data in user defaults
        if let updatedCities = UserDefaults.standard.value(forKey: WeatherConstants.userDefaults.updatedCitiesKey) as? [Int] {
            citiIdArray = updatedCities
        }
        
        if !citiIdArray.contains(newCity) {
            // Inserting added city on top of to list
            citiIdArray.insert(newCity, at: 0)
            
            // storing the added city in the User Defaults
            UserDefaults.standard.set(citiIdArray, forKey: WeatherConstants.userDefaults.updatedCitiesKey)
        } else {
            return [0]
        }
        
        getWeatherData()
        
        return citiIdArray
    }
    
    // MARK: - API call to get weather data
    func getWeatherData() {
        
        // Saving cities in user defaults as of now, need to create core data / realm / firebase
        // Retrieving the cities from UserDefaults
        if  UserDefaults.standard.value(forKey: WeatherConstants.userDefaults.updatedCitiesKey) as? [Int] == nil {
            
            // Keeping the default cities
            citiIdArray.append(Cities.London.rawValue)
            citiIdArray.append(Cities.Paris.rawValue)
            UserDefaults.standard.set(citiIdArray, forKey: WeatherConstants.userDefaults.updatedCitiesKey)
        }
        
        if let updatedCities = UserDefaults.standard.value(forKey: WeatherConstants.userDefaults.updatedCitiesKey) as? [Int] {
            apiService.getWeatherAPI(parameter: [WeatherConstants.API.idParameterKey : updatedCities], completion: { [weak self] (weatherData, error)  in
                // Passing the weather model and error to view controller
                self?.bindVMToVC?(weatherData, error)
            })
        }
    }
    
    // MARK: - Fetch CityId from city name
    func getCityIdByCityName(name: String) -> Int? {
        if let cityDataList = cityData {
            for city in cityDataList {
                /* Returing city id based on user entered city name and city name in the local
                 open weather json  */
                if city.name == name {
                    return city.id
                }
            }
        }
        return nil
    }
}

