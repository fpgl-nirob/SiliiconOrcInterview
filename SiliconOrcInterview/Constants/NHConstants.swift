//
//  NHConstants.swift
//  Template
//
//  Created by mac pro-t1 on 1/22/20.
//  Copyright © 2020 mac pro-t1. All rights reserved.
//

import Foundation
import UIKit

func NHLog(_ msg: Any?) {
    #if DEBUG
        if let _msg = msg { print(_msg) }
    #endif
}

func NHTestUI(_ imageName:String) {
    
    let window = UIApplication.shared.keyWindow
    //add image view
    if let _window  = window {
        let imageView   = UIImageView(frame: _window.frame)
        imageView.image = UIImage(named: imageName)
        imageView.alpha = 0.3
        _window.addSubview(imageView)
    }
}

struct NHConstants {
    struct UserDefaultKeys {
        //static let VERIFICATION_ID_KEY = "kVerificationIdKey"
    }
    
    struct Path {
        static let DOCUMENTS_DIRECTORY = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as String
        static let TEMP_DIRECTORY = NSTemporaryDirectory()
    }
    
    struct FontNames {
        struct SFProDisplay {
            static let SF_PRO_DISPLAY_REGULAR = "SFProDisplay-Regular"
            static let SF_PRO_DISPLAY_BOLD = "SFProDisplay-Bold"
            static let SF_PRO_DISPLAY_SEMIBOLD = "SFProDisplay-Semibold"
        }
        struct SFProText {
            static let SF_PRO_TEXT_REGULAR = "SFProText-Regular"
            static let SF_PRO_TEXT_BOLD = "SFProText-Bold"
            static let SF_PRO_TEXT_SEMIBOLD = "SFProText-Semibold"
        }
    }
    
    struct Database {
        static let FileName = "Test"
        static let FileExt = "sqlite"
    }
    
    struct ApplicationValues {
        static let IS_IPAD = UI_USER_INTERFACE_IDIOM() == .pad
        static let WIN_SIZE = UIScreen.main.bounds.size
        static let DISPLAY_SCALE = WIN_SIZE.width/375.0
        static let DEFAULT_BUTTON_HEIGHT: CGFloat = 50.0
    }
    
    struct DefaultLocation {
        // for dhaka
        static let LATITUDE  = 23.8103
        static let LONGITUDE = 90.4125
    }
    
    struct APIConstants {
        //https://reqres.in/api/users?page=2
        static let BASE_URL = "http://dummy.restapiexample.com/"
        static let USER_LIST = "api/v1/employees"
    }
}


