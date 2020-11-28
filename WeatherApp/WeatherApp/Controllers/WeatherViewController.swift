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
    
    lazy var loadingIdicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        self.view.addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ])
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        callVMForUIUpdate()
    }
    
    func callVMForUIUpdate() {
        weatherViewModel = WeatherViewModel()
        loadingIdicator.startAnimating()
        weatherViewModel.bindVMToVC = { 
            self.weatherInfo = self.weatherViewModel.weatherData
            self.loadingIdicator.stopAnimating()
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
                cell.weatherConfigurable(weatherCity: weatherCity)
                return cell
            }
        }
        return UITableViewCell()
    }
}

extension WeatherViewController: AddCityDelegate {
    func userAddedCity(name: String) {
        if !name.trimmingCharacters(in: .whitespaces).isEmpty {
            loadingIdicator.startAnimating()
            if weatherViewModel.addNewCity(name: name) == nil {
                DispatchQueue.main.async {
                    self.alert(message: "Error in getting weather!", title: "WeatherApp")
                }
                loadingIdicator.stopAnimating()
            }
        }
    }
}
