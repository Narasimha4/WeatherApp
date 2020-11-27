//
//  APIService.swift
//  WeatherApp
//
//  Created by N, Narasimhulu on 23/11/20.
//  Copyright © 2020 Narasimha. All rights reserved.
//

import Foundation

class APIService: NSObject {
    
    let WEATHER_API = "http://api.openweathermap.org/data/2.5/group?"
    let APP_ID = "3fc7eb54f2da81b1fa92df9d7951a11d"
    
    func makeNetworkCall(parameter: [String : [Int]], completion: @escaping (WeatherModel) -> ()) {
        
        let urlComp = NSURLComponents(string: WEATHER_API)!
        var items = [URLQueryItem]()
        for (key,value) in parameter {
            items.append(URLQueryItem(name: key, value: (value.map {String($0)}).joined(separator: ",")))
        }
        items = items.filter{!$0.name.isEmpty}
        if !items.isEmpty {
            items.append(URLQueryItem(name: "appid", value: APP_ID))
            urlComp.queryItems = items
        }
        var urlRequest = URLRequest(url: urlComp.url!)
        urlRequest.httpMethod = "GET"
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            
            if error == nil && data != nil {
                do {
                    let responseModel =  try JSONDecoder().decode(WeatherModel.self, from: data!)
                    DispatchQueue.main.async {
                        completion(responseModel)
                    }
                }
                catch {
                    DispatchQueue.main.async {
                        //self.showError()
                    }
                }
            }
            else if error != nil
            {
                DispatchQueue.main.async {
                    //self.showError()
                }
            }
        })
        task.resume()
    }
}
