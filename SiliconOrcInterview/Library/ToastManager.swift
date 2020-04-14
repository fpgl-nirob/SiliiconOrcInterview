//
//  ToastManager.swift
//  quran-ios
//
//  Created by mac pro-t1 on 5/16/19.
//  Copyright © 2019 mac pro-t1. All rights reserved.
//

import UIKit
import Toaster

final class ToastManager: NSObject {
    static let shared = ToastManager()
    
    private override init() {
        let toastView = ToastView.appearance()
        toastView.backgroundColor = UIColor.black
        toastView.textColor = UIColor.white
        toastView.font = UIFont.systemFont(ofSize: 15.0)
        toastView.cornerRadius = 5.0
    }
    
    func showToast(text: String) -> Void {
        let toast = Toast(text: text, delay: 0.0, duration: 2.0)
        toast.show()
    }
}
