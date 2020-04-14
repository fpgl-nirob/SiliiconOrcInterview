//
//  UIFont+Extension.swift
//  Template
//
//  Created by mac pro-t1 on 2/2/20.
//  Copyright © 2020 mac pro-t1. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    class func SFProDisplayRegular(ofSize: CGFloat) -> UIFont {
        return UIFont(name: NHConstants.FontNames.SFProDisplay.SF_PRO_DISPLAY_REGULAR, size: ofSize)!
    }
    
    class func SFProDisplayBold(ofSize: CGFloat) -> UIFont {
        return UIFont(name: NHConstants.FontNames.SFProDisplay.SF_PRO_DISPLAY_BOLD, size: ofSize)!
    }
    
    class func SFProDisplaySemiBold(ofSize: CGFloat) -> UIFont {
        return UIFont(name: NHConstants.FontNames.SFProDisplay.SF_PRO_DISPLAY_SEMIBOLD, size: ofSize)!
    }
    
    class func SFProTextRegular(ofSize: CGFloat) -> UIFont {
        return UIFont(name: NHConstants.FontNames.SFProText.SF_PRO_TEXT_REGULAR, size: ofSize)!
    }
    
    class func SFProTextBold(ofSize: CGFloat) -> UIFont {
        return UIFont(name: NHConstants.FontNames.SFProText.SF_PRO_TEXT_BOLD, size: ofSize)!
    }
    
    class func SFProTextSemiBold(ofSize: CGFloat) -> UIFont {
        return UIFont(name: NHConstants.FontNames.SFProText.SF_PRO_TEXT_SEMIBOLD, size: ofSize)!
    }
}
