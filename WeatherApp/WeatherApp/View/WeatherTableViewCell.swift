//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by N, Narasimhulu on 23/11/20.
//  Copyright © 2020 Narasimha. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var cityImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cityImageView.layer.cornerRadius = 17.0
        
    }
    
    func weatherConfigurable(weatherCity: List) {
        
        let temparature = Temperature(country: (weatherCity.sys?.country!)!, openWeatherMapDegrees: (weatherCity.main?.temp!)!)
        let sunriseTime = DateHelper.getTimeFromUnixTimeStamp(timeStamp: (weatherCity.sys?.sunrise)!, timeZone: (weatherCity.sys?.timezone)!)
        let sunsetTime = DateHelper.getTimeFromUnixTimeStamp(timeStamp: (weatherCity.sys?.sunset)!, timeZone: (weatherCity.sys?.timezone)!)
        
        DispatchQueue.main.async {
            self.temperatureLabel.text = temparature.degrees
            self.humidityLabel.text = "\(weatherCity.main?.humidity! ?? 0)%"
            self.cityLabel.text = weatherCity.name
            self.sunriseLabel.text = sunriseTime
            self.sunsetLabel.text = sunsetTime
            self.cityImageView.image = UIImage.init(named: weatherCity.name == Cities.London.rawValue || weatherCity.name == Cities.Paris.rawValue ? weatherCity.name ?? "" :  "Default")
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
