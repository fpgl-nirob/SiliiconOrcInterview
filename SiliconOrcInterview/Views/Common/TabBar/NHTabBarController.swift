//
//  NHTabBarController.swift
//  UniversalTest
//
//  Created by mac pro-t1 on 1/20/20.
//  Copyright © 2020 mac pro-t1. All rights reserved.
//

import UIKit

class NHTabBarController: UITabBarController {
    var firstVC: FirstViewController!
    var secondVC: SecondViewController!
    var thirdVC: ThirdViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.isHidden = true
        
        // Need to maintain line order for the below lines
        createCustomTabBar()
        setupViewControllers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func createCustomTabBar() {
        let customTabbar = NHTabBar.shared
        customTabbar.tabBarDelegate = self
        
        self.view.addSubview(customTabbar)
    }
    
    func setupViewControllers() {
        let stiryboardMain = UIStoryboard(name: "Main", bundle: nil)
        firstVC = stiryboardMain.instantiateViewController(withIdentifier: "FirstViewController") as? FirstViewController
        secondVC = stiryboardMain.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController
        thirdVC = stiryboardMain.instantiateViewController(withIdentifier: "ThirdViewController") as? ThirdViewController
        
        self.viewControllers = [firstVC, secondVC, thirdVC]
    }
    
    func gotoSecondPage(_dbSindleEmployee: DBSingleEmployee) {
        secondVC.dbSingleEmployee = _dbSindleEmployee
        let customTabbar = NHTabBar.shared
        customTabbar.secondItemButtonClicked(customTabbar.secondItemButton as Any)
    }

}

extension NHTabBarController: NHTabBarDelegate {
    func tabBarItemClicked(button: UIButton) {
        self.selectedIndex = button.tag - 1
    }
}
