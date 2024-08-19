//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by N, Narasimhulu on 19/08/24.
//  Copyright © 2024 Narasimha. All rights reserved.
//

import XCTest
@testable import WeatherApp

class WeatherAppTests: XCTestCase {
        
    // View model object creation
    var viewModel = WeatherViewModel()
    
    var service: APIService!
    var sessionUnderTest : URLSession!
    var url: URL?
    
    override func setUp() {
        super.setUp()
        
        // setting default session configuration
        sessionUnderTest = URLSession(configuration : URLSessionConfiguration.default)
        
        // setting url string directy with query parameters
        url = URL(string: "http://api.openweathermap.org/data/2.5/group?id=524901&appid=3fc7eb54f2da81b1fa92df9d7951a11d")
    }
    
    
    //MARK: Slow failure Async test
    // API success test case
    func testAPISuccessStatus200(){
        
        // status code 200
        let promise = expectation(description: "Status code : 200")
        
        sessionUnderTest.dataTask(with: url!) { (data, response, error) in
            if let error = error{
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else{
                    XCTFail("Status code = \(statusCode)")
                }
            }
        }.resume()
        waitForExpectations(timeout: 5, handler: nil)
    }
    
     //MARK: Get city id from city name test
    func testGetCityIdFromName() {
        let cityId = viewModel.getCityIdByCityName(name: "London")
        XCTAssertEqual(cityId, 123, "Couldn't match id")
    }
    
    override func tearDown() {
        service = nil
        super.tearDown()
    }
}
