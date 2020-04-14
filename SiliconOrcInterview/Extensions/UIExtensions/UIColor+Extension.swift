//
//  ExtensionUIColor.swift
//  Choku_ios
//
//  Created by chitra bonik on 10/10/19.
//  Copyright © 2019 Oceanize. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init?(hex: String) {
        
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt32 = 0
        
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        
        let length = hexSanitized.count
        
        guard Scanner(string: hexSanitized).scanHexInt32(&rgb) else { return nil }
        
        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
            
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
            
        } else {
            return nil
        }
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    convenience init(rgbValue: Int) {
        self.init(red: CGFloat(rgbValue) / 255.0, green: CGFloat(rgbValue) / 255.0, blue: CGFloat(rgbValue) / 255.0, alpha: 1.0)
    }
    
    class func _ashTextColor() -> UIColor {
        return UIColor.init(rgbValue: 143)
    }

    class func _ashLightColor() -> UIColor {
        return UIColor(red: 32/255.0, green: 32/255.0, blue: 32/255.0, alpha: 0.5)
    }
    
    class func _errorRedColor() -> UIColor {
        return UIColor.init(red: 250/255, green: 3/255, blue: 33/255, alpha: 1.0)
    }
    
    class func _DarkRedColor() -> UIColor {
        return UIColor.init(red: 208, green: 52, blue: 53)
    }
    
}
