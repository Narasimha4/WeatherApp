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
    
    lazy var weatherViewModel: WeatherViewModel = {
        return WeatherViewModel()
    }()
    
    lazy var loadingIndicator: UIActivityIndicatorView = {
        var indicator: UIActivityIndicatorView!
        if  #available(iOS 13.0, *) {
            indicator = UIActivityIndicatorView(style: .large)
        } else {
            indicator = UIActivityIndicatorView(style: .medium)
        }
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        self.view.addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        return indicator
    }()
    
    var weatherInfo: WeatherModel?
    var reachability: Reachability?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reachability = Reachability()
        
        NotificationCenter.default.addObserver(self, selector: #selector(networkStatusChanged(_:)), name: .reachabilityChanged, object: reachability)
        
        do {
            try reachability?.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    @objc func networkStatusChanged(_ notification: Notification) {
        let networkReachability = notification.object as? Reachability
        let remoteHostStatus = networkReachability?.connection
        switch remoteHostStatus {
        case .cellular, .wifi:
            callVMForUIUpdate()
        default:
            guard ReachabilityManager.shared.isConnectedToNetwork() else {
                self.loadingIndicator.stopAnimating()
                self.alert(message: WeatherConstants.Texts.internetConnectionMessage, title: WeatherConstants.Texts.appTitle)
                return
            }
        }
    }
    
    func callVMForUIUpdate() {
        loadingIndicator.startAnimating()
        weatherViewModel.bindVMToVC = { (weatherData, error) in
            if let error = error  {
                self.loadingIndicator.stopAnimating()
                self.alert(message: error.localizedDescription, title: WeatherConstants.Texts.appTitle)
                return
            }
            self.weatherInfo = weatherData
            self.loadingIndicator.stopAnimating()
            DispatchQueue.main.async {
                self.weatherTableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as? AddCityViewController
        destinationVC?.delegate = self
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
        loadingIndicator.startAnimating()
        let trimmedName = name.trimmingCharacters(in: .whitespaces)
        if weatherViewModel.addNewCity(name: trimmedName) == nil {
            self.alert(message: WeatherConstants.Texts.unableToGetWeatherMessage, title: WeatherConstants.Texts.appTitle)
            loadingIndicator.stopAnimating()
        }
    }
}
