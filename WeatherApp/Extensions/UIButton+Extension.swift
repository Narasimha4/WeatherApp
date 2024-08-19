//
//  UIButton+Extension.swift
//  WeatherApp
//
//  Created by N, Narasimhulu on 19/08/24.
//  Copyright © 2024 Narasimha. All rights reserved.
//

import UIKit

extension UIButton {
    
    // MARK: - Add shadow to button
    func drawShadow() {
        self.layer.shadowOpacity = 0.7
        self.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
    }
}
