//
//  UIViewController+Extension.swift
//  WeatherApp
//
//  Created by N, Narasimhulu on 27/11/20.
//  Copyright © 2020 Narasimha. All rights reserved.
//

import UIKit

extension UIViewController {
    func alert(message: String, title: String ) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let OKAction = UIAlertAction(title: WeatherConstants.Texts.okButtonText, style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
