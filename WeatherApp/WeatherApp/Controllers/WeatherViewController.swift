//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by N, Narasimhulu on 23/11/20.
//  Copyright © 2020 Narasimha. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var weatherTableView: UITableView!
    
    var weatherViewModel: WeatherViewModel!
    var weatherInfo: WeatherModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        callVMForUIUpdate()
    }
    
    func callVMForUIUpdate() {
        weatherViewModel = WeatherViewModel()
        weatherViewModel.bindVMToVC = {
            self.weatherInfo = self.weatherViewModel.weatherData
            self.weatherTableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! AddCityViewController
        destinationVC.delegate = self
    }
}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = weatherInfo?.cnt {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 354
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "\(WeatherTableViewCell.self)", for: indexPath) as? WeatherTableViewCell {
            if let weatherCity = weatherInfo?.list?[indexPath.row] {
                
                
                DispatchQueue.main.async {
                    
                    let temparature = Temperature(country: (weatherCity.sys?.country!)!, openWeatherMapDegrees: (weatherCity.main?.temp!)!)
                    cell.temperatureLabel.text = temparature.degrees
                    cell.humidityLabel.text = "\(weatherCity.main?.humidity! ?? 0)%"
                    cell.cityLabel.text = weatherCity.name
                    
                    cell.sunriseLabel.text = DateHelper.getTimeFromUnixTimeStamp(timeStamp: (weatherCity.sys?.sunrise)!, timeZone: (weatherCity.sys?.timezone)!)
                    cell.sunsetLabel.text = DateHelper.getTimeFromUnixTimeStamp(timeStamp: (weatherCity.sys?.sunset)!, timeZone: (weatherCity.sys?.timezone)!)
                    
                    if weatherCity.name == Cities.London.rawValue || weatherCity.name == Cities.Paris.rawValue {
                        cell.cityImageView.image = UIImage.init(named: weatherCity.name ?? "")
                    } else {
                        cell.cityImageView.image = UIImage.init(named: "Default")
                    }
                }
                return cell
            }
            
        }
        return UITableViewCell()
    }
}

extension WeatherViewController: AddCityDelegate {
    func userAddedCity(name: String) {
        if !name.trimmingCharacters(in: .whitespaces).isEmpty {
            if weatherViewModel.addNewCity(name: name) == nil {
                DispatchQueue.main.async {
                    self.alert(message: "Error in getting weather!", title: "WeatherApp")
                }
            }
        }
    }
}
