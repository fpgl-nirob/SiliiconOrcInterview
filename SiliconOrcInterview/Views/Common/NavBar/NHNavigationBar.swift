//
//  NHNavigationBar.swift
//  UniversalTest
//
//  Created by mac pro-t1 on 1/21/20.
//  Copyright © 2020 mac pro-t1. All rights reserved.
//

import UIKit

@objc protocol NHNavigationBarDelegate {
    @objc optional func backButtonClicked()
    @objc optional func rightButtonClicked()
}

class NHNavigationBar: UIView {
    private var titleLabel: UILabel! = UILabel()
    private var buttonBack: UIButton = UIButton(type: .custom)
    private var buttonRight: UIButton = UIButton(type: .custom)
    private var buttonBackImageView: UIImageView = UIImageView()
    
    weak var navDelegate: NHNavigationBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        initialSetup()
    }
    
    private func initialSetup() {
        addSubview(titleLabel)
        layoutIfNeeded()
    }
    
    // Set title label
    public func setTitleLabel(title: String) {
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 17.scale(), weight: .medium)
        titleLabel.textColor = .white
        titleLabel.sizeToFit()
        titleLabel.frame =  CGRect(x: 100.scale(), y: 5.scale(), width: 175.scale(), height: 24.scale())
        titleLabel.textAlignment = .center
    }
    
    // Set back button
    func setBackButton(_title: String = "") {
        self.buttonBack.removeFromSuperview()
        buttonBack.frame = CGRect(x: 20.0.scale(), y: 5.0.scale(), width: 2*24.0.scale(), height: 24.0.scale())
        self.buttonBack.center.y = self.titleLabel.center.y
        self.buttonBack.contentHorizontalAlignment = .left
        buttonBack.addTarget(self, action: #selector(self.backButtonClicked(_:)), for: .touchUpInside)
        self.addSubview(self.buttonBack)
        
        if _title == "" {
            buttonBackImageView.frame = CGRect(x: 1.0.scale(), y: 1.0.scale(), width: 22.0.scale(), height: 22.0.scale())
            buttonBackImageView.contentMode = .scaleAspectFit
            buttonBackImageView.image = UIImage(named: "button_back")
            self.buttonBack.addSubview(buttonBackImageView)
        }
        else {
            self.buttonBack.setTitle(_title, for: .normal)
            self.buttonBack.setTitleColor(UIColor.white, for: .normal)
            self.buttonBack.contentHorizontalAlignment = .right
            self.buttonBack.titleLabel?.font = UIFont.systemFont(ofSize: 17.0.scale(), weight: .medium)
        }
    }
    
    // Set right button
    func setRightButton(_title: String) {
        self.buttonRight.removeFromSuperview()
        self.buttonRight.setTitle(_title, for: .normal)
        self.buttonRight.setTitleColor(UIColor.white, for: .normal)
        self.buttonRight.contentHorizontalAlignment = .right
        self.buttonRight.titleLabel?.font = UIFont.systemFont(ofSize: 24.0.scale(), weight: .medium)
        
        self.buttonRight.frame.size = CGSize(width: 60.0.scale(), height: 24.0.scale())
        self.buttonRight.frame.origin.x = NHConstants.ApplicationValues.WIN_SIZE.width - 80.0.scale()
        self.buttonRight.center.y = self.titleLabel.center.y
        
        self.buttonRight.addTarget(self, action: #selector(self.rightButtonClicked(_:)), for: .touchUpInside)
        self.addSubview(self.buttonRight)
    }
    
    @objc func backButtonClicked(_ sender: UIButton) {
        navDelegate?.backButtonClicked?()
    }
    
    @objc func rightButtonClicked(_ sender: UIButton) {
        navDelegate?.rightButtonClicked?()
    }

}
