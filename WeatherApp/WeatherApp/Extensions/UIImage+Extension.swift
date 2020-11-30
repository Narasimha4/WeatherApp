//
//  UIImage+Extension.swift
//  WeatherApp
//
//  Created by N, Narasimhulu on 29/11/20.
//  Copyright © 2020 Narasimha. All rights reserved.
//

import UIKit

public enum DeviceSpecific {
    case iPhone
    case iPhoneRetina
    case iPhone5
    case iPhone6
    case iPhone6Plus
    case iPad
    case iPadRetina
    case Unknown
}

public extension UIImage {

    private class func currentDeviceSpecific() -> DeviceSpecific {
        
        let h = Float(UIScreen.main.bounds.size.height)
        let w = Float(UIScreen.main.bounds.size.width)
        let pixelDimension = Int(fmaxf(h, w))
        
        switch pixelDimension {
        case 480:
            return UIScreen.main.scale > 1.0 ? .iPhoneRetina : .iPhone
        case 568:
            return .iPhone5
        case 667:
            return .iPhone6
        case 736:
            return .iPhone6Plus
        case 1024:
            return UIScreen.main.scale > 1.0 ? .iPadRetina : .iPad
        default:
            return .Unknown
        }
    }
    
    private class func suffixForDevice() -> String {
        switch currentDeviceSpecific() {
            case .iPhone:
                return ""
            case .iPhoneRetina:
                return "@2x"
            case .iPhone5:
                return "@2x"
            case .iPhone6:
                return "@2x"
            case .iPhone6Plus:
                return "@3x"
            case .iPad, .iPadRetina:
                return "~Ipad"
            case .Unknown:
                return ""
        }
    }
    
    class func imageForSpecificDevice(imageName: String) -> UIImage? {
        var result: UIImage? = nil
        let nameWithSuffix = imageName+UIImage.suffixForDevice()
        result = UIImage(named: nameWithSuffix)
        if result == nil {
            result = UIImage(named: imageName)
        }
        return result
    }
}
