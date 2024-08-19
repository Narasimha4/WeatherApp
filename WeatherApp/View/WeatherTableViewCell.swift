//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by N, Narasimhulu on 19/08/24.
//  Copyright © 2024 Narasimha. All rights reserved.
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
        
        // Initial setup of the cell
        initialSetup()
    }
    
    // MARK: - Cosmetic setup of cell
    func initialSetup() {
        
        // Imageview initial setup
        cityImageView.layer.addLayer()
        cityImageView.layer.cornerRadius = 17
    }
    
    // MARK: - Configure the weather data in the cell
    func weatherConfigurable(weatherCity: List) {
        
        DispatchQueue.main.async {
            // setting up the humidity
            self.humidityLabel.text = "\(weatherCity.main?.humidity ?? 0)%"
            
            // setting up the city name
            self.cityLabel.text = weatherCity.name
            
            // setting up the image name for iPhone and iPad devices
            // Based on default cities set the image eg: city name - London, ImageName - London
            // If we are adding new city set the default image, which is stored in the assets
            self.cityImageView.image = UIImage.imageForSpecificDevice(imageName: weatherCity.name == "\(Cities.London)" || weatherCity.name == "\(Cities.Paris)" ? weatherCity.name ?? "" : WeatherConstants.Texts.defaultImageNmae)
            
            // setting up the temparate
            if let county = weatherCity.sys?.country, let temp = weatherCity.main?.temp {
                // method that will return the temparature in celsius / Farenhiet
                let temparature = Temperature(country: county, openWeatherMapDegrees: temp)
                self.temperatureLabel.text = temparature.degrees
            }
            
            //setting up the sunrise
            if let sunriseTime = weatherCity.sys?.sunrise, let timeZone = weatherCity.sys?.timezone {
                //A Method that will return the time from unix time stamp
                self.sunriseLabel.text = DateHelper.getTimeFromUnixTimeStamp(timeStamp: sunriseTime, timeZone: timeZone)
            }
            
            // setting up the sunset
            if let sunsetTime = weatherCity.sys?.sunset, let timeZone = weatherCity.sys?.timezone {
                 //A Method that will return the time from unix time stamp
                self.sunsetLabel.text = DateHelper.getTimeFromUnixTimeStamp(timeStamp: sunsetTime, timeZone: timeZone)
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
