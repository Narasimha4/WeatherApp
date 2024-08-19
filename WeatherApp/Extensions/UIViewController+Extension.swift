//
//  UIViewController+Extension.swift
//  WeatherApp
//
//  Created by N, Narasimhulu on 19/08/24.
//  Copyright © 2024 Narasimha. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // MARK: - Generic alert for VC extension
    func alert(message: String, title: String ) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let OKAction = UIAlertAction(title: WeatherConstants.Texts.okButtonText, style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
