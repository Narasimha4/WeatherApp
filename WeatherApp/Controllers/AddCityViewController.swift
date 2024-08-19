//
//  AddCityViewController.swift
//  WeatherApp
//
//  Created by N, Narasimhulu on 19/08/24.
//  Copyright © 2020 Narasimha. All rights reserved.
//

import UIKit

//PROTOCOL: delegate for add city
protocol AddCityDelegate {
    // user added city declaration
    func userAddedCity(name: String) -> [Int]?
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
        cityTextField.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
      view.endEditing(true)
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
        let newCitiesId = delegate?.userAddedCity(name: cityTextField.text ?? "")
        if newCitiesId != nil && newCitiesId != [0] {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension AddCityViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
