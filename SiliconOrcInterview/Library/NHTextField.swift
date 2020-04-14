//
//  NHTextField.swift
//  Khushu
//
//  Created by Elo on 17/3/19.
//  Copyright © 2019 Elo. All rights reserved.
//

import UIKit

@objc protocol NHTextFieldDelegate {
    @objc optional func textFieldShouldBeginEditing(textField: NHTextField) -> Bool
    @objc optional func textFieldRightButtonClicked(textField: NHTextField)
    @objc optional func textFieldLeftButtonClicked(textField: NHTextField)
    @objc optional func textFieldDidChanged(textField: NHTextField)
}

class NHTextField: UITextField {
    
    weak var textFDelegate: NHTextFieldDelegate?
    var isCapitalized = true
    
    public override init(frame: CGRect) {
        super.init(frame:frame)
        
        initializeSetup()
        //print("NHTextField-init-frame")
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //initializeSetup()
        //print("NHTextField-init-coder")
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        initializeSetup()
        //print("NHTextField-awakeFromNib")
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    private func initializeSetup() {
        
        self.delegate = self
        
        self.borderStyle = .roundedRect
        self.autocapitalizationType     = .none;
        self.autocorrectionType         = .no;
        self.clearButtonMode            = .whileEditing;
        self.contentVerticalAlignment   = .center;
        self.autocapitalizationType = .sentences
        self.font                       = UIFont.systemFont(ofSize: 15.0.scale(), weight: .regular)
        self.textColor                  = .black
//        self.tintColor                  = NHTheme.shared.THEME_GRAY_LITE_BG
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        self.backgroundColor            = .white
        
        let lview = UIView()
        lview.frame = CGRect(x: 0, y: 0, width: 8.0, height: self.bounds.size.height)
        lview.backgroundColor = UIColor.clear
        self.leftView = lview
        self.leftViewMode = .always
        
        let rview = UIView()
        rview.frame = CGRect(x: 0, y: 0, width: 8.0, height: self.bounds.size.height)
        rview.backgroundColor = UIColor.clear
        self.rightView = rview
        self.rightViewMode = .always
        
//        self.layer.cornerRadius = 3.0
        
        self.addTarget(self, action: #selector(textFieldDidChanged(textField:)), for: .editingChanged)
        
    }
    
    public func removeLeftView() {
        let lview = UIView()
        lview.frame = CGRect(x: 0, y: 0, width: 1.0, height: self.bounds.size.height)
        lview.backgroundColor = UIColor.clear
        self.leftView = lview
        self.leftViewMode = .always
    }
    
    public func removeRightView() {
        let rview = UIView()
        rview.frame = CGRect(x: 0, y: 0, width: 1.0, height: self.bounds.size.height)
        rview.backgroundColor = UIColor.clear
        self.rightView = rview
        self.rightViewMode = .always
    }
    
    public func setLeftIcon(_ image: UIImage) {
        
        let iconSize:CGSize = CGSize(width: self.bounds.size.height*0.4, height: self.bounds.size.height*0.4)
        
        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: iconSize.width+10.0, height: iconSize.height+10.0))
        
        let iconView = UIImageView(frame: CGRect(x: 10.0, y: iconContainerView.bounds.size.height/2 - (iconSize.height)/2, width: iconSize.width, height: iconSize.height))
        iconView.contentMode = .scaleAspectFit
        iconView.image = image
        
        iconContainerView.addSubview(iconView)
        self.leftView = iconContainerView
        self.leftViewMode = .always
        
        let gesture = MyGesture.init(target: self, action: #selector(textFieldLeftButtonClicked(gesture:)))
        gesture.numberOfTapsRequired = 1
        gesture.tag = 1
        iconContainerView.addGestureRecognizer(gesture)
    }
    
    public func setRightIcon(_ image: UIImage) {
        
        let iconSize:CGSize = CGSize(width: self.bounds.size.height*0.4, height: self.bounds.size.height*0.4)
        
        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: iconSize.width+10.0, height: iconSize.height+10.0))
        
        let iconView = UIImageView(frame: CGRect(x: 0.0, y: iconContainerView.bounds.size.height/2 - (iconSize.height)/2, width: iconSize.width, height: iconSize.height))
        iconView.contentMode = .scaleAspectFit
        iconView.image = image
        
        iconContainerView.addSubview(iconView)
        self.rightView = iconContainerView
        self.rightViewMode = .always
        
        //textFieldRightButtonClicked
        let gesture = MyGesture.init(target: self, action: #selector(textFieldRightButtonClicked(gesture:)))
        gesture.numberOfTapsRequired = 1
        gesture.tag = 1
        iconContainerView.addGestureRecognizer(gesture)
    }
    
    @objc private func textFieldDidChanged(textField: NHTextField) {
        print("textFieldDidChanged \(textField.text ?? "nulllll")")
        textFDelegate?.textFieldDidChanged?(textField: textField)
    }
    
    @objc private func textFieldRightButtonClicked(gesture: MyGesture) {
        print("optionClicked tag \(gesture.tag)")
        guard let method = textFDelegate?.textFieldRightButtonClicked else {
            return
        }
        method(self)
    }
    
    @objc private func textFieldLeftButtonClicked(gesture: MyGesture) {
        print("optionClicked tag \(gesture.tag)")
        guard let method = textFDelegate?.textFieldLeftButtonClicked else {
            return
        }
        method(self)
    }
    
    public func addSelectedProperties() {
        //addBorderProperties(borderWidth: 2.0, borderColor: NHTheme.shared.THEME_DEEP_GREEN, shadowColor: NHTheme.shared.THEME_PURE_WHITE)
        textFieldDidBeginEditing(self)
    }
    
    public func addNonSelectedProperties() {
        //clearBorderProperties()
        textFieldDidEndEditing(self)
    }
    
    private func addBorderProperties(borderWidth:CGFloat, borderColor:UIColor, shadowColor:UIColor) {
        
        //To apply border
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        
        //To apply Shadow
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 3.0
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0) // Use any CGSize
        self.layer.shadowColor = shadowColor.cgColor
    }
    
    private func clearBorderProperties() {
        
        //To apply border
        self.layer.borderColor = UIColor.clear.cgColor
        
        //To apply Shadow
        self.layer.shadowOpacity = 0.0
        self.layer.shadowRadius = 0.0
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0) // Use any CGSize
        self.layer.shadowColor = UIColor.clear.cgColor
    }

}

extension NHTextField: UITextFieldDelegate {
    // Mark- UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        addBorderProperties(borderWidth: 2.0, borderColor: NHTheme.shared.THEME_DEEP_GREEN, shadowColor: NHTheme.shared.THEME_PURE_WHITE)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        clearBorderProperties()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("textFieldShouldBeginEditing")
        guard let method = textFDelegate?.textFieldShouldBeginEditing else {
            return true
        }
        return method(textField as! NHTextField)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if self.text != nil && !self.text!.isEmpty && isCapitalized {
            //self.text = self.text?.capitalizingFirstLetter()
        }
        return true
    }
    
}
