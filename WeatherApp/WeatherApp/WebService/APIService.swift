//
//  APIService.swift
//  WeatherApp
//
//  Created by N, Narasimhulu on 23/11/20.
//  Copyright © 2020 Narasimha. All rights reserved.
//

import Foundation

class APIService: NSObject {
        
    func getWeatherAPI(parameter: [String : [Int]], completion: @escaping (WeatherModel?, Error?) -> ()) {
        
        let urlComp = NSURLComponents(string: WeatherConstants.API.urlString)
        var items = [URLQueryItem]()
        for (key,value) in parameter {
            items.append(URLQueryItem(name: key, value: (value.map {String($0)}).joined(separator: ",")))
        }
        items = items.filter{!$0.name.isEmpty}
        if !items.isEmpty {
            items.append(URLQueryItem(name: WeatherConstants.API.appIdParameterKey, value: WeatherConstants.appIdKey))
            urlComp?.queryItems = items
        }
        
        guard let url = urlComp?.url else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = WeatherConstants.API.httpMethodGetType
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            
            if error == nil && data != nil {
                do {
                    let responseModel =  try JSONDecoder().decode(WeatherModel.self, from: data!)
                    DispatchQueue.main.async {
                        completion(responseModel, nil)
                    }
                }
                catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
            else if error != nil
            {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        })
        task.resume()
    }
}
