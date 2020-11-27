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
        
        drawShadow(getWeatherButton)
    }
    
    func drawShadow(_ button: UIButton) {
        button.layer.shadowOpacity = 0.7
        button.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func getWeatherButtonTapped(_ sender: Any) {
        
        guard let textField = cityTextField.text, !textField.isEmpty else {
            self.alert(message: "Please enter the city name", title: "WeatherApp")
            return
        }
        
        delegate?.userAddedCity(name: cityTextField.text ?? "")
        self.dismiss(animated: true, completion: nil)
    }
}
