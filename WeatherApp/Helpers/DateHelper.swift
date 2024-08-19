//
//  DateHelper.swift
//  WeatherApp
//
//  Created by N, Narasimhulu on 19/08/24.
//  Copyright © 2024 Narasimha. All rights reserved.
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
