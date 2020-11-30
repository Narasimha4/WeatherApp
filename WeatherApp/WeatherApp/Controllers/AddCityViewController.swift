//
//  AddCityViewController.swift
//  WeatherApp
//
//  Created by N, Narasimhulu on 27/11/20.
//  Copyright © 2020 Narasimha. All rights reserved.
//

import UIKit

//PROTOCOL: delegate for add city
protocol AddCityDelegate {
    
    // user added city declaration
    func userAddedCity(name: String)
}

class AddCityViewController: UIViewController {
    
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var getWeatherButton: UIButton!
    
    // Add city
    var delegate: AddCityDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // add shadow to the button
        getWeatherButton.drawShadow()
    }
    
    //MARK: Back button Action
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Get weather button Action
    @IBAction func getWeatherButtonTapped(_ sender: Any) {
        
        // guard check for city field
        guard let textField = cityTextField.text, !textField.isEmpty else {
            self.alert(message: WeatherConstants.Texts.cityNameRequiredMessage, title: WeatherConstants.Texts.appTitle)
            return
        }
        
        // guard check for internet connection
        guard ReachabilityManager.shared.isConnectedToNetwork() else {
            self.alert(message: WeatherConstants.Texts.internetConnectionMessage, title: WeatherConstants.Texts.appTitle)
            return
        }
        
        // delegate call for add new city
        delegate?.userAddedCity(name: cityTextField.text ?? "")
        self.dismiss(animated: true, completion: nil)
    }
}
