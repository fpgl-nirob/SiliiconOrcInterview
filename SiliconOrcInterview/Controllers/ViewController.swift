//
//  ViewController.swift
//  SiliconOrcInterview
//
//  Created by Nirob Hasan on 13/4/20.
//  Copyright © 2020 Nirob Hasan. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: BaseViewController {
    @IBOutlet weak var nhNavigationBar: NHNavigationBar!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var tempTableView: UITableView!
    
    private var employeeList: [APISingleEmployee] = [APISingleEmployee]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nhNavigationBar.navDelegate = self
        hintLabel.font = UIFont.systemFont(ofSize: 17.0.scale(), weight: .bold)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.setupNavBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let employee = NHDBManager.shared.getEmployee(_employeeId: 24)
        if employee.employeeId == 0 {
            self.callAPIForCustomerList()
        }
        else {
            self.rightButtonClicked()
        }
    }

    func setupNavBar() {
        nhNavigationBar.setTitleLabel(title: "Temp View")
        nhNavigationBar.setRightButton(_title: "CRUD")
    }
    
    func callAPIForCustomerList() {
        NHAPIServices.callAPIForTest(completionHandler:{[weak self] (result, error) in
            if let _result = result {
                // success
                self?.employeeList.removeAll()
                for emplyee in _result {
                    let jsonData = JSON(emplyee)
                    let apiSingleEmployee = APISingleEmployee.getDBSingleEmployeeFromJSON(jsonData: jsonData)
                    self?.employeeList.append(apiSingleEmployee)
                    let success = NHDBManager.shared.insertIntoEmploye(_apiSingleEmployee: apiSingleEmployee)
                    if success {
                        NHLog("insert into employee successfully")
                    }
                    else {
                        NHLog("insert into employee error")
                    }
                }
                self?.tempTableView.reloadData()
            }
            else {
                // error
            }
            NHLog("nirob-test: back")
        })
    }

}

extension ViewController: NHNavigationBarDelegate {
    func backButtonClicked() {
        
    }
    
    func rightButtonClicked() {
        (UIApplication.shared.delegate as! AppDelegate).setupRootViewController()
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.employeeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TempViewCell.reuseIdentifier()) as? TempViewCell else {
            fatalError("The dequeued cell is not an instance of TempViewCell.")
        }
        let singleEmployee = self.employeeList[indexPath.row]
        cell.nameLabel.text = "Name: " + (singleEmployee.employee_name ?? "")
        cell.salaryLabel.text = "Salary: " + String(singleEmployee.employee_salary)
        cell.ageLabel.text = "Age: " + String(singleEmployee.employee_age)
        
        
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

