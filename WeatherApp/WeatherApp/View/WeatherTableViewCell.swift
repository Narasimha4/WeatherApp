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
        
        initialSetup()
    }
    
    func initialSetup() {
        cityImageView.layer.addLayer()
        cityImageView.layer.cornerRadius = 17
    }
    
    func weatherConfigurable(weatherCity: List) {
        
        DispatchQueue.main.async {
            self.humidityLabel.text = "\(weatherCity.main?.humidity ?? 0)%"
            self.cityLabel.text = weatherCity.name
            self.cityImageView.image = UIImage.init(named: weatherCity.name == "\(Cities.London)" || weatherCity.name == "\(Cities.Paris)" ? weatherCity.name ?? "" : WeatherConstants.Texts.defaultImageNmae)
            
            if let county = weatherCity.sys?.country, let temp = weatherCity.main?.temp {
                let temparature = Temperature(country: county, openWeatherMapDegrees: temp)
                self.temperatureLabel.text = temparature.degrees
            }
            
            if let sunriseTime = weatherCity.sys?.sunrise, let timeZone = weatherCity.sys?.timezone {
                self.sunriseLabel.text = DateHelper.getTimeFromUnixTimeStamp(timeStamp: sunriseTime, timeZone: timeZone)
            }
            
            if let sunsetTime = weatherCity.sys?.sunset, let timeZone = weatherCity.sys?.timezone {
                self.sunsetLabel.text = DateHelper.getTimeFromUnixTimeStamp(timeStamp: sunsetTime, timeZone: timeZone)
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
