//
//  NHTabbar.swift
//  UniversalTest
//
//  Created by mac pro-t1 on 1/20/20.
//  Copyright © 2020 mac pro-t1. All rights reserved.
//

import UIKit

@objc protocol NHTabBarDelegate {
    @objc optional func tabBarItemClicked(button: UIButton)
}

class NHTabBar: UIView {
    @IBOutlet weak var firstIconLabel: UILabel!
    @IBOutlet weak var secondIconLabel: UILabel!
    @IBOutlet weak var thirdIconLabel: UILabel!
    @IBOutlet weak var fourthIconLabel: UILabel!
    @IBOutlet weak var fifthIconLabel: UILabel!
    
    @IBOutlet weak var firstIconImageView: UIImageView!
    @IBOutlet weak var secondIconImageView: UIImageView!
    @IBOutlet weak var thirdIconImageView: UIImageView!
    @IBOutlet weak var fourthIconImageView: UIImageView!
    @IBOutlet weak var fifthIconImageView: UIImageView!
    
    @IBOutlet weak var firstItemButton: UIButton!
    @IBOutlet weak var secondItemButton: UIButton!
    @IBOutlet weak var thirdItemButton: UIButton!
    @IBOutlet weak var fourthItemButton: UIButton!
    @IBOutlet weak var fifthItemButton: UIButton!
    
    private weak var selectedButton: UIButton!
    public weak var tabBarDelegate: NHTabBarDelegate?
    
    private var iconImageNames = [["footer_home", "footer_notification", "footer_home", "footer_notification", "footer_home"], ["footer_home_selected", "footer_notification_selected", "footer_home_selected", "footer_notification_selected", "footer_home_selected"]]
    private var iconLabelNames = ["Home", "Noti", "Scan", "Delivery", "Camera"]
    
    
    static let shared: NHTabBar = {
        let view: NHTabBar = Bundle.main.loadNibNamed("NHTabBar", owner: self, options: nil)?[0] as! NHTabBar
        var safeAreaheight: CGFloat = 0.0
        if #available(iOS 11.0, *) {
            if let appDelegate: AppDelegate = UIApplication.shared.delegate as? AppDelegate {
                safeAreaheight = safeAreaheight + (appDelegate.window?.safeAreaInsets.bottom ?? 0.0)
            }
        }

        view.frame = CGRect(x: 0, y: NHConstants.ApplicationValues.WIN_SIZE.height - (69.scale() + safeAreaheight), width: NHConstants.ApplicationValues.WIN_SIZE.width, height: 69.scale() + safeAreaheight)
        view.layoutIfNeeded()
        
        print("safeAreaheight \(safeAreaheight) view.height \(view.frame.size.height)")
        
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        firstIconLabel.font = UIFont.systemFont(ofSize: 10.scale(), weight: .medium)
        secondIconLabel.font = UIFont.systemFont(ofSize: 10.scale(), weight: .medium)
        thirdIconLabel.font = UIFont.systemFont(ofSize: 10.scale(), weight: .medium)
        fourthIconLabel.font = UIFont.systemFont(ofSize: 10.scale(), weight: .medium)
        fifthIconLabel.font = UIFont.systemFont(ofSize: 10.scale(), weight: .medium)
        
        selectedButton = firstItemButton
        updateTabBarButtons()
    }
    
    func updateTabBarButtons() {
        //deselect all buttton
        firstItemButton.isSelected = false
        secondItemButton.isSelected = false
        thirdItemButton.isSelected = false
        fourthItemButton.isSelected = false
        fifthItemButton.isSelected = false
        
        selectedButton.isSelected = true
        
        //set Label
        firstIconLabel.text = iconLabelNames[0]
        secondIconLabel.text = iconLabelNames[1]
        thirdIconLabel.text = iconLabelNames[2]
        fourthIconLabel.text = iconLabelNames[3]
        fifthIconLabel.text = iconLabelNames[4]
        
        firstIconLabel.textColor = UIColor.lightGray
        secondIconLabel.textColor = UIColor.lightGray
        thirdIconLabel.textColor = UIColor.lightGray
        fourthIconLabel.textColor = UIColor.lightGray
        fifthIconLabel.textColor = UIColor.lightGray
        
        //set image
        firstIconImageView.image = UIImage(named: iconImageNames[0][0])
        secondIconImageView.image = UIImage(named: iconImageNames[0][1])
        thirdIconImageView.image = UIImage(named: iconImageNames[0][2])
        fourthIconImageView.image = UIImage(named: iconImageNames[0][3])
        fifthIconImageView.image = UIImage(named: iconImageNames[0][4])
        
        // For button01
        if selectedButton?.tag == 1 {
            firstIconImageView.image = selectedButton!.isSelected ? UIImage(named: iconImageNames[1][0]) : UIImage(named: iconImageNames[0][0])
            firstIconLabel.textColor = UIColor.darkGray
        }
        
        // For button02
        if selectedButton?.tag == 2 {
            secondIconImageView.image = selectedButton!.isSelected ? UIImage(named: iconImageNames[1][1]) : UIImage(named: iconImageNames[0][1])
            secondIconLabel.textColor = UIColor.darkGray
        }
        
        // For button03
        if selectedButton?.tag == 3 {
            thirdIconImageView.image = selectedButton!.isSelected ? UIImage(named: iconImageNames[1][2]) : UIImage(named: iconImageNames[0][2])
            thirdIconLabel.textColor = UIColor.darkGray
        }
        
        // For button04
        if selectedButton?.tag == 4 {
            fourthIconImageView.image = selectedButton!.isSelected ? UIImage(named: iconImageNames[1][3]) : UIImage(named: iconImageNames[0][3])
            fourthIconLabel.textColor = UIColor.darkGray
        }
        
        // For button05
        if selectedButton?.tag == 5 {
            fifthIconImageView.image = selectedButton!.isSelected ? UIImage(named: iconImageNames[1][4]) : UIImage(named: iconImageNames[0][4])
            fifthIconLabel.textColor = UIColor.darkGray
        }
        
    }
    
    @IBAction func firstItemButtonClicked(_ sender: Any) {
        selectedButton = firstItemButton
        updateTabBarButtons()
        tabBarDelegate?.tabBarItemClicked?(button: firstItemButton)
    }
    
    @IBAction func secondItemButtonClicked(_ sender: Any) {
        selectedButton = secondItemButton
        updateTabBarButtons()
        tabBarDelegate?.tabBarItemClicked?(button: secondItemButton)
    }
    
    @IBAction func thirdItemButtonClicked(_ sender: Any) {
        selectedButton = thirdItemButton
        updateTabBarButtons()
        tabBarDelegate?.tabBarItemClicked?(button: thirdItemButton)
    }
    
    @IBAction func fourthItemButtonClicked(_ sender: Any) {
        selectedButton = fourthItemButton
        updateTabBarButtons()
        tabBarDelegate?.tabBarItemClicked?(button: fourthItemButton)
    }
    
    @IBAction func fifthItemButtonClicked(_ sender: Any) {
        selectedButton = fifthItemButton
        updateTabBarButtons()
        tabBarDelegate?.tabBarItemClicked?(button: fifthItemButton)
    }
    
}
