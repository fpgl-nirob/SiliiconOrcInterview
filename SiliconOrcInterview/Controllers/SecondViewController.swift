//
//  SecondViewController.swift
//  SiliconOrcInterview
//
//  Created by Nirob Hasan on 14/4/20.
//  Copyright © 2020 Nirob Hasan. All rights reserved.
//

import UIKit

class SecondViewController: BaseViewController {
    @IBOutlet weak var nhNavigationBar: NHNavigationBar!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    
    @IBOutlet weak var rating1: UIButton!
    @IBOutlet weak var rating2: UIButton!
    @IBOutlet weak var rating3: UIButton!
    @IBOutlet weak var rating4: UIButton!
    @IBOutlet weak var rating5: UIButton!
    
    public var dbSingleEmployee: DBSingleEmployee = DBSingleEmployee()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nhNavigationBar.navDelegate = self
        dbSingleEmployee = NHDBManager.shared.getEmployee(_employeeId: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupNavBar()
        self.setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupNavBar() {
        nhNavigationBar.setTitleLabel(title: "Employee Info")
    }
    
    func setupUI() {
        //self.profileImageView.image = dbSingleEmployee.profile_image
        self.nameLabel.text = dbSingleEmployee.employee_name
        self.ageLabel.text = String(dbSingleEmployee.employee_age)
        self.salaryLabel.text = String(dbSingleEmployee.employee_salary)
    }
    
    @IBAction func ratingButtonClicked(_ sender: Any) {
        let button = sender as! UIButton
        if button.tag == 1 {
            rating1.setImage(UIImage(named: "rating"), for: .normal)
            rating2.setImage(UIImage(named: "ratingdisabled"), for: .normal)
            rating3.setImage(UIImage(named: "ratingdisabled"), for: .normal)
            rating4.setImage(UIImage(named: "ratingdisabled"), for: .normal)
            rating5.setImage(UIImage(named: "ratingdisabled"), for: .normal)
        }
        else if button.tag == 2 {
            rating1.setImage(UIImage(named: "rating"), for: .normal)
            rating2.setImage(UIImage(named: "rating"), for: .normal)
            rating3.setImage(UIImage(named: "ratingdisabled"), for: .normal)
            rating4.setImage(UIImage(named: "ratingdisabled"), for: .normal)
            rating5.setImage(UIImage(named: "ratingdisabled"), for: .normal)
        }
        else if button.tag == 3 {
            rating1.setImage(UIImage(named: "rating"), for: .normal)
            rating2.setImage(UIImage(named: "rating"), for: .normal)
            rating3.setImage(UIImage(named: "rating"), for: .normal)
            rating4.setImage(UIImage(named: "ratingdisabled"), for: .normal)
            rating5.setImage(UIImage(named: "ratingdisabled"), for: .normal)
        }
        else if button.tag == 4 {
            rating1.setImage(UIImage(named: "rating"), for: .normal)
            rating2.setImage(UIImage(named: "rating"), for: .normal)
            rating3.setImage(UIImage(named: "rating"), for: .normal)
            rating4.setImage(UIImage(named: "rating"), for: .normal)
            rating5.setImage(UIImage(named: "ratingdisabled"), for: .normal)
        }
        else if button.tag == 5 {
            rating1.setImage(UIImage(named: "rating"), for: .normal)
            rating2.setImage(UIImage(named: "rating"), for: .normal)
            rating3.setImage(UIImage(named: "rating"), for: .normal)
            rating4.setImage(UIImage(named: "rating"), for: .normal)
            rating5.setImage(UIImage(named: "rating"), for: .normal)
        }
    }
    

}

extension SecondViewController: NHNavigationBarDelegate {
    func backButtonClicked() {
        
    }
    
    func rightButtonClicked() {
        
    }
    
}
