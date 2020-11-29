//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by N, Narasimhulu on 23/11/20.
//  Copyright © 2020 Narasimha. All rights reserved.
//

import XCTest
@testable import WeatherApp

class WeatherAppTests: XCTestCase {
    
    var service: APIService!
    var viewModel = WeatherViewModel()
    
    var sessionUnderTest : URLSession!
    var url: URL?
    
    override func setUp() {
        super.setUp()
        
        sessionUnderTest = URLSession(configuration : URLSessionConfiguration.default)
        url = URL(string: "http://api.openweathermap.org/data/2.5/group?id=524901&appid=3fc7eb54f2da81b1fa92df9d7951a11d")
    }
    
    
    // Slow failure Async test : RENT
    func testAPISuccessStatus200(){
        
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
    
    func testGetCityIdFromName() {
        let cityId = viewModel.getCityIdByCityName(name: "London")
        XCTAssertEqual(cityId, 123, "Couldn't match id")
    }
    
    override func tearDown() {
        service = nil
        super.tearDown()
    }
}
