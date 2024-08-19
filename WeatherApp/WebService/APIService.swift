//
//  APIService.swift
//  WeatherApp
//
//  Created by N, Narasimhulu on 19/08/24.
//  Copyright © 2024 Narasimha. All rights reserved.
//

import Foundation

class APIService: NSObject {
    
    // MARK: - API to get weather data
    // API, which takes city ids as parameter and returns the weather data for cities
    func getWeatherAPI(parameter: [String : [Int]], completion: @escaping (WeatherModel?, Error?) -> ()) {
        
        let urlComp = NSURLComponents(string: WeatherConstants.API.urlString)
        // Query parameter
        var items = [URLQueryItem]()
        for (key,value) in parameter {
            // Joining the Int arrays to strings and separated by commas
            items.append(URLQueryItem(name: key, value: (value.map {String($0)}).joined(separator: ",")))
        }
        items = items.filter{!$0.name.isEmpty}
        if !items.isEmpty {
            // query parameter of open weather APPID
            items.append(URLQueryItem(name: WeatherConstants.API.appIdParameterKey, value: WeatherConstants.appIdKey))
            urlComp?.queryItems = items
        }
        
        // guard check for url
        guard let url = urlComp?.url else { return }
        var urlRequest = URLRequest(url: url)
        
        // HttpMethod - Get
        urlRequest.httpMethod = WeatherConstants.API.httpMethodGetType
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // URLSession as data task
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            // API success
            if error == nil && data != nil {
                // Serialize the data into an Object
                do {
                    let responseModel =  try JSONDecoder().decode(WeatherModel.self, from: data!)
                    DispatchQueue.main.async {
                        //return the weather model
                        completion(responseModel, nil)
                    }
                }  catch {
                    DispatchQueue.main.async {
                        // managing the error
                        completion(nil, error)
                    }
                }
                // Check an error if occured
            } else if error != nil   { // API failure
                DispatchQueue.main.async {
                    // managing the error
                    completion(nil, error)
                }
            }
        })
        task.resume()
    }
}
