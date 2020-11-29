//
//  AddCityViewController.swift
//  WeatherApp
//
//  Created by N, Narasimhulu on 27/11/20.
//  Copyright © 2020 Narasimha. All rights reserved.
//

import UIKit

protocol AddCityDelegate {
    func userAddedCity(name: String)
}

class AddCityViewController: UIViewController {
    
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var getWeatherButton: UIButton!
    
    var delegate: AddCityDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWeatherButton.drawShadow()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func getWeatherButtonTapped(_ sender: Any) {
        
        guard let textField = cityTextField.text, !textField.isEmpty else {
            self.alert(message: WeatherConstants.Texts.cityNameRequiredMessage, title: WeatherConstants.Texts.appTitle)
            return
        }
        
        guard ReachabilityManager.shared.isConnectedToNetwork() else {
            self.alert(message: WeatherConstants.Texts.internetConnectionMessage, title: WeatherConstants.Texts.appTitle)
            return
        }
        
        delegate?.userAddedCity(name: cityTextField.text ?? "")
        self.dismiss(animated: true, completion: nil)
    }
}
