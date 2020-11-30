//
//  DateHelper.swift
//  WeatherApp
//
//  Created by N, Narasimhulu on 27/11/20.
//  Copyright © 2020 Narasimha. All rights reserved.
//

import UIKit

class DateHelper {
    
    // MARK: - Get time from time stamp
    static func getTimeFromUnixTimeStamp(timeStamp: Int, timeZone: Int) -> String {
        let date = Date(timeIntervalSince1970: Double(timeStamp))
        let formatter = DateFormatter()
        // time formatter as HH.mm
        formatter.dateFormat = WeatherConstants.Texts.timeFormatter
        formatter.timeZone = TimeZone(secondsFromGMT: timeZone)
        let formattedTime = formatter.string(from: date)
        
        return formattedTime
    }
    
}
