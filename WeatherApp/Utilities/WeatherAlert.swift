//
//  UIViewController+Extension.swift
//  WeatherApp
//
//  Created by N, Narasimhulu on 27/11/20.
//  Copyright © 2020 Narasimha. All rights reserved.
//

import UIKit

class WeatherAlert {
    
    // AlertView Function
    func alertMsg(message: String, actionButtonTitle: String, title: String) {
        DispatchQueue.main.async {
            let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: actionButtonTitle, style: .default, handler: nil))
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = UIViewController()
            window.windowLevel = UIWindow.Level.alert
            window.makeKeyAndVisible()
            window.rootViewController?.present(alertView, animated: false, completion: nil)
        }
    }
}
