//
//  ExtensionNumber.swift
//  Choku_ios
//
//  Created by chitra bonik on 10/10/19.
//  Copyright © 2019 Oceanize. All rights reserved.
//

import UIKit

extension Double {
    func scale() -> CGFloat {
        return CGFloat(self) * NHConstants.ApplicationValues.DISPLAY_SCALE
    }
}

extension Int {
    func scale() -> CGFloat {
        return CGFloat(self) * NHConstants.ApplicationValues.DISPLAY_SCALE
    }
    
    func isLeapYear() -> Bool {
        return (( self % 100 != 0) && (self % 4 == 0)) || (self % 400 == 0)
    }
}

extension CGFloat {
    func scale() -> CGFloat {
        return CGFloat(self) * NHConstants.ApplicationValues.DISPLAY_SCALE
    }
}
