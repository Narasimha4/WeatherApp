//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by N, Narasimhulu on 19/08/24.
//  Copyright © 2024 Narasimha. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var weatherTableView: UITableView!
    
    // Lazy initialization for view model
    lazy var weatherViewModel: WeatherViewModel = {
        return WeatherViewModel()
    }()
    
    // Progress indicator
    lazy var loadingIndicator: UIActivityIndicatorView = {
        var indicator: UIActivityIndicatorView!
        indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        self.view.addSubview(indicator)
        
        // Constraints programmatically
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
        
        // Initialization of reachability object
        reachability = Reachability()
        
        // Network status Observer for notify Online / offline
        NotificationCenter.default.addObserver(self, selector: #selector(networkStatusChanged(_:)), name: .reachabilityChanged, object: reachability)
        // try catch for start notifier 
        do {
            try reachability?.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    //MARK: Network Status Observer
    @objc func networkStatusChanged(_ notification: Notification) {
        let networkReachability = notification.object as? Reachability
        let remoteHostStatus = networkReachability?.connection
        switch remoteHostStatus {
        // internet connection is available
        case .cellular, .wifi:
            callViewModelForUIUpdate()
        // internet connection is unavailable
        default:
            
            // guard check for internet availability
            guard ReachabilityManager.shared.isConnectedToNetwork() else {
                self.loadingIndicator.stopAnimating()
                self.alert(message: WeatherConstants.Texts.internetConnectionMessage, title: WeatherConstants.Texts.appTitle)
                return
            }
        }
    }
    
    //MARK: Method to call view model for update UI
    func callViewModelForUIUpdate() {
        loadingIndicator.startAnimating()
        weatherViewModel.bindVMToVC = { (weatherData, error) in
            if let error = error  {
                self.loadingIndicator.stopAnimating()
                // managing error
                self.alert(message: error.localizedDescription, title: WeatherConstants.Texts.appTitle)
                return
            }
            self.weatherInfo = weatherData
            self.loadingIndicator.stopAnimating()
            
            // Reloading the tableview/list once data updated
            DispatchQueue.main.async {
                self.weatherTableView.reloadData()
            }
        }
    }
    
    //MARK: Seque for Add view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as? AddCityViewController
        destinationVC?.delegate = self
    }
}

//MARK: Tableview delegtes and data source
extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Return number of rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = weatherInfo?.cnt {
            return count
        }
        return 0
    }
    
    //MARK: Height of the row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // setting up the row / cell height
        // width 336 as per design both iPhone and iPad
        // bottom padding 18
        // 336 + 18 =354
        return 354
    }
    
    //MARK: Data Source of tableview / List
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // optional binding to load WeatherTableViewCell
        if let cell = tableView.dequeueReusableCell(withIdentifier: "\(WeatherTableViewCell.self)", for: indexPath) as? WeatherTableViewCell {
            if let weatherCity = weatherInfo?.list?[indexPath.row] {
                // Configure the weather city for each row
                cell.weatherConfigurable(weatherCity: weatherCity)
                return cell
            }
        }
        
        // return empty cell if WeatherTableViewCell won't available
        return UITableViewCell()
    }
}

//MARK: Extension for Add city delegate of add view controller
extension WeatherViewController: AddCityDelegate {
    
    //MARK: Definition of user added city
    func userAddedCity(name: String) -> [Int]? {
        loadingIndicator.startAnimating()
        // removing the extra spaces leading / trailing spaces in the city name
        let trimmedName = name.trimmingCharacters(in: .whitespaces)
        
        // based on add new city, if failed to add new city
        // display the alert as erroe while getting weather'
        let newCitiesId = weatherViewModel.addNewCity(name: trimmedName)
        switch newCitiesId {
        case [0]:
            alert(message: WeatherConstants.Texts.existWeatherMessage,
                       title: WeatherConstants.Texts.appTitle)
        case nil:
            alert(message: WeatherConstants.Texts.unableToGetWeatherMessage,
                       title: WeatherConstants.Texts.appTitle)
        default: ()
        }
        loadingIndicator.stopAnimating()
        return newCitiesId
    }
}
