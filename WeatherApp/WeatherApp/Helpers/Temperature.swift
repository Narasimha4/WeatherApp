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
        
        // Based US country return the temperature degree as Celsius / Fareheit
        if country == WeatherConstants.Texts.usCountryText {
            degrees = String(TemperatureConverter.kelvinToFahrenheit(openWeatherMapDegrees)) + "°" // °F
        } else {
            degrees = String(TemperatureConverter.kelvinToCelsius(openWeatherMapDegrees)) + "°" // °C
        }
    }
}
