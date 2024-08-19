//
//  WeatherConstants.swift
//  WeatherApp
//
//  Created by N, Narasimhulu on 19/08/24.
//  Copyright © 2024 Narasimha. All rights reserved.
//

import UIKit

struct WeatherConstants {
    
    // Open Weather APPID
    static let appIdKey = "3fc7eb54f2da81b1fa92df9d7951a11d"
    
    // API related constants
    struct API {
        static let urlString = "http://api.openweathermap.org/data/2.5/group"
        static let idParameterKey = "id"
        static let appIdParameterKey = "appid"
        static let httpMethodGetType = "GET"
        
    }
    
    // App related constants
    struct Texts {
        static let okButtonText = "OK"
        static let jsonFileType = "json"
        static let timeFormatter = "HH.mm"
        static let defaultImageNmae = "Default"
        static let jsonFileNmae = "city.list"
        static let appTitle = "WeatherApp"
        static let internetConnectionMessage = "An internet connection is required.\n Please try again after a connection is established"
        static let unableToGetWeatherMessage = "Searched city does not exist, please try other cities."
        static let existWeatherMessage = "Searched city weather is already added, please try with new city."
        static let cityNameRequiredMessage = "Please enter the city name"
        static let usCountryText = "US"
    }
    
    // UserDefault keys
    struct userDefaults {
        static let updatedCitiesKey = "updatedCities"
    }
}
