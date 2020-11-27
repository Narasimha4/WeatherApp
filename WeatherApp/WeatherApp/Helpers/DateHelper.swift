//
//  DateHelper.swift
//  WeatherApp
//
//  Created by N, Narasimhulu on 27/11/20.
//  Copyright © 2020 Narasimha. All rights reserved.
//

import UIKit

class DateHelper {
    static func getTimeFromUnixTimeStamp(timeStamp: Int, timeZone: Int) -> String {
        let date = Date(timeIntervalSince1970: Double(timeStamp))
        let formatter = DateFormatter()
        formatter.dateFormat = "HH.mm"
        formatter.timeZone = TimeZone(secondsFromGMT: timeZone)
        let formattedTime = formatter.string(from: date)
        
        return formattedTime
    }
    
}
