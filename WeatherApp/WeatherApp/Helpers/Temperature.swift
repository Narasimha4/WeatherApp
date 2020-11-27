//
//  Temperature.swift
//  WeatherApp
//
//  Created by N, Narasimhulu on 26/11/20.
//  Copyright © 2020 Narasimha. All rights reserved.
//

import Foundation

struct Temperature {
    let degrees: String
    
    init(country: String, openWeatherMapDegrees: Double) {
        if country == "US" {
            degrees = String(TemperatureConverter.kelvinToFahrenheit(openWeatherMapDegrees)) + "°"
        } else {
            degrees = String(TemperatureConverter.kelvinToCelsius(openWeatherMapDegrees)) + "°"
        }
    }
}
