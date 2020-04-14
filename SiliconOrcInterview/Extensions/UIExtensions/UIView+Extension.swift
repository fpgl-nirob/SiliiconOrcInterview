//
//  UIView+Extension.swift
//  Khushu
//
//  Created by Elo on 27/4/19.
//  Copyright © 2019 Elo. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    /**
     Rounds the given set of corners to the specified radius
     
     - parameter corners: Corners to round
     - parameter radius:  Radius to round to
     */
    func round(corners: UIRectCorner, radius: CGFloat) {
        //_ = _round(corners: corners, radius: radius)
        let mask = _round(corners: corners, radius: radius)
        addBorder(mask: mask, borderColor: UIColor.clear, borderWidth: 0.0)
    }
    
    /**
     Rounds the given set of corners to the specified radius with a border
     
     - parameter corners:     Corners to round
     - parameter radius:      Radius to round to
     - parameter borderColor: The border color
     - parameter borderWidth: The border width
     */
    func round(corners: UIRectCorner, radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        let mask = _round(corners: corners, radius: radius)
        addBorder(mask: mask, borderColor: borderColor, borderWidth: borderWidth)
    }
    
    func round(radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
        if borderWidth > 0.0 {
            self.layer.borderWidth = borderWidth
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    func round(radius: CGFloat) {
        self.round(radius: radius, borderColor: UIColor.clear, borderWidth: 0.0)
    }
    
    /**
     Fully rounds an autolayout view (e.g. one with no known frame) with the given diameter and border
     
     - parameter diameter:    The view's diameter
     - parameter borderColor: The border color
     - parameter borderWidth: The border width
     */
    func fullyRound(borderColor: UIColor = UIColor.clear, borderWidth: CGFloat = 0.0) {
        layer.masksToBounds = true
        layer.cornerRadius = self.frame.height/2
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }
    
    // Example use: myView.addBorder(toSide: .Left, withColor: UIColor.redColor().CGColor, andThickness: 1.0)
    
    enum ViewSide {
        case left, right, top, bottom
    }
    
    func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {
        
        let border = CALayer()
        border.backgroundColor = color
        
        switch side {
        case .left: border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.size.height); break
        case .right: border.frame = CGRect(x: self.frame.size.width - thickness, y: 0, width: thickness, height: self.frame.size.height); break
        case .top: border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: thickness); break
        case .bottom: border.frame = CGRect(x: 0, y: self.frame.size.height - thickness, width: self.frame.size.width, height: thickness); break
        }
        
        layer.addSublayer(border)
    }
    
    func addBorder(borderColor: UIColor, borderWidth: CGFloat) {
        layer.masksToBounds = true
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }
    
    enum GradientMode {
        case horizontal, vertical
    }
    
    func addGradient(_colors: [CGColor], _locations: [NSNumber], _gradientMode: GradientMode) {
        let gradient: CAGradientLayer = CAGradientLayer()

        gradient.colors = _colors
        gradient.locations = _locations
        if _gradientMode == .horizontal {
            gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        }
        else {
            gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        }
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height)

        self.layer.addSublayer(gradient)
    }
    
    func addGradient(color1: UIColor, color2: UIColor) {
        let gradient: CAGradientLayer = CAGradientLayer()

        gradient.colors = [color1.cgColor, color2.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height)

        self.layer.addSublayer(gradient)
    }

    // roundWithShadow function works well all UIView elements except UITextView
    // if apply roundWithShadow to UITextView then the text is going upper from the bounds frame.
    func roundWithShadow(_cornerRadius: CGFloat, _shadowOpacity: Float, _shadowRadius: CGFloat, _shadowColor: UIColor, _shadowOffset: CGSize = CGSize(width: 0.0, height: 0.0)) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = _cornerRadius
        
        //To apply Shadow
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = _shadowOpacity
        self.layer.shadowRadius = _shadowRadius
        self.layer.shadowOffset = _shadowOffset // Use any CGSize
        self.layer.shadowColor = _shadowColor.cgColor
    }
}

private extension UIView {
    
    @discardableResult func _round(corners: UIRectCorner, radius: CGFloat) -> CAShapeLayer {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        return mask
    }
    
    func addBorder(mask: CAShapeLayer, borderColor: UIColor, borderWidth: CGFloat) {
        let borderLayer = CAShapeLayer()
        borderLayer.path = mask.path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.lineWidth = borderWidth
        borderLayer.frame = bounds
        layer.addSublayer(borderLayer)
    }
    
}
