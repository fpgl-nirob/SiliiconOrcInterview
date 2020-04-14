//
//  ExtensionSpacing.swift
//  Choku_ios
//
//  Created by chitra bonik on 10/10/19.
//  Copyright © 2019 Oceanize. All rights reserved.
//

import UIKit

extension UILabel {
    
    func letterSpacing(spacing: CGFloat = 0.0) {
        
        guard let labelText = text else { return }
        
        let attributedString: NSMutableAttributedString
        
        if let labelAttributedText = attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelAttributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        //Letter Spacing Attributed
        attributedString.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSMakeRange(0, attributedString.length))
        attributedText = attributedString
    }
    
    func lineSpacing(spacing: CGFloat = 0.0) {
        
        guard let labelText = text else { return }
        
        let attributedString: NSMutableAttributedString
        
        if let labelAttributedText = attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelAttributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        //Line Spacing Attributed
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        attributedText = attributedString
    }
    
    func setLineHeight(_lineHeightMultiple: CGFloat) {
        let paragraphStyle = NSMutableParagraphStyle()
        //paragraphStyle.lineSpacing = 1.0
        paragraphStyle.lineHeightMultiple = _lineHeightMultiple
        paragraphStyle.alignment = self.textAlignment


        let attrString = NSMutableAttributedString()
        if (self.attributedText != nil) {
            attrString.append( self.attributedText!)
        } else {
            attrString.append( NSMutableAttributedString(string: self.text!))
            attrString.addAttribute(NSAttributedString.Key.font, value: self.font as Any, range: NSMakeRange(0, attrString.length))
        }
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        self.attributedText = attrString
    }
    
}

extension UITextField {
    
    func letterSpacing(spacing: CGFloat = 0.0) {
        
        guard let labelText = text else { return }
        
        let attributedString: NSMutableAttributedString
        if let labelAttributedText = attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelAttributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        //Letter Spacing Attribute
        attributedString.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSMakeRange(0, attributedString.length))
        attributedText = attributedString
    }
    
    func lineSpacing(spacing: CGFloat = 0.0) {
        
        guard let labelText = text else { return }
        
        let attributedString: NSMutableAttributedString
        if let labelAttributedText = attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelAttributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        //Line Spacing Attributed
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        attributedText = attributedString
    }
}

extension UITextView {
    func letterSpacing(spacing: CGFloat = 0.0) {
        
        guard let labelText = text else { return }
        
        let attributedString: NSMutableAttributedString
        if let labelAttributedText = attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelAttributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        //Letter spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSMakeRange(0, attributedString.length))
        attributedText = attributedString
    }
    
    func lineSpacing(spacing: CGFloat = 0.0) {
        
        guard let labelText = text else { return }
        
        let attributedString: NSMutableAttributedString
        if let labelAttributedText = attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelAttributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        //Line Spacing Attributed
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        attributedText = attributedString
    }
}

extension UIButton {
    
    func letterSpacing(spacing: CGFloat = 0.0) {
        
        guard let labelText = titleLabel?.text else { return }
        
        let attributedString: NSMutableAttributedString
        
        if let labelAttributedText = titleLabel?.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelAttributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        //Letter Spacing Attributed
        attributedString.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSMakeRange(0, attributedString.length))
        titleLabel?.attributedText = attributedString
    }
    
    func lineSpacing(spacing: CGFloat = 0.0) {
        
        guard let labelText = titleLabel?.text else { return }
        
        let attributedString: NSMutableAttributedString
        
        if let labelAttributedText = titleLabel?.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelAttributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        //Line Spacing Attributed
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        titleLabel?.attributedText = attributedString
    }
}


