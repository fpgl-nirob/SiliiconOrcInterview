//
//  FirstViewController.swift
//  SiliconOrcInterview
//
//  Created by Nirob Hasan on 14/4/20.
//  Copyright © 2020 Nirob Hasan. All rights reserved.
//

import UIKit

class FirstViewController: BaseViewController {
    @IBOutlet weak var nhNavigationBar: NHNavigationBar!
    @IBOutlet weak var customerTableView: UITableView!
    @IBOutlet weak var searchField: NHTextField!
    
    private var employeeList: [DBSingleEmployee] = [DBSingleEmployee]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nhNavigationBar.navDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupNavBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.callDBForCustomerList()
    }
    
    func callDBForCustomerList() {
        self.employeeList = NHDBManager.shared.getEmployees()
        self.customerTableView.reloadData()
    }
    
    func setupNavBar() {
        nhNavigationBar.setTitleLabel(title: "Employee List")
        nhNavigationBar.setBackButton(_title: "Filter")
        nhNavigationBar.setRightButton(_title: "+")
    }
    
    func showAlertViewForEditName(_singleEmployee: DBSingleEmployee) {
        let alertController = UIAlertController(title: "Edit Name", message: "", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Employee Name"
        }
        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
            let firstTextField = alertController.textFields![0] as UITextField
            let success = NHDBManager.shared.updateEmployeeName(_employeeId: _singleEmployee.employeeId, _name: firstTextField.text ?? "")
            if success {
                ToastManager.shared.showToast(text: "Successfully Edited the employee name")
                _singleEmployee.employee_name = firstTextField.text
                self.customerTableView.reloadData()
            }
            else {
                ToastManager.shared.showToast(text: "Employee name can't updated")
            }
            
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
            (action : UIAlertAction!) -> Void in
            
        })

        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertViewForAddEmployee() {
        let alertController = UIAlertController(title: "Add Employee", message: "", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.keyboardType = .default
            textField.placeholder = "Enter Employee Name"
        }
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.keyboardType = .decimalPad
            textField.placeholder = "Enter Employee Salary"
        }
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.keyboardType = .decimalPad
            textField.placeholder = "Enter Employee Age"
        }
        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: {[weak self] alert -> Void in
            
            let nameTextField = alertController.textFields![0] as UITextField
            let salaryTextField = alertController.textFields![1] as UITextField
            let ageTextField = alertController.textFields![2] as UITextField
            
            let isOk = !(nameTextField.text?.isEmpty ?? true) && !(salaryTextField.text?.isEmpty ?? true) && !(ageTextField.text?.isEmpty ?? true)
            
            if let weakSelft = self, isOk {
                let _apiSingleEmployee = APISingleEmployee()
                _apiSingleEmployee.employeeId = weakSelft.employeeList[weakSelft.employeeList.count - 1].employeeId + 1
                _apiSingleEmployee.employee_name = nameTextField.text
                _apiSingleEmployee.employee_salary = Int(salaryTextField.text ?? "0") ?? 0
                _apiSingleEmployee.employee_age = Int(ageTextField.text ?? "0") ?? 0
                
                let success = NHDBManager.shared.insertIntoEmploye(_apiSingleEmployee: _apiSingleEmployee)
                //let success = NHDBManager.shared.updateEmployeeName(_employeeId: _singleEmployee.employeeId, _name: firstTextField.text ?? "")
                if success {
                    ToastManager.shared.showToast(text: "Successfully Edited the employee name")
                    weakSelft.employeeList.append(_apiSingleEmployee.convertToDBSingleEmployee())
                    weakSelft.customerTableView.reloadData()
                }
                else {
                    ToastManager.shared.showToast(text: "Employee name can't updated")
                }
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
            (action : UIAlertAction!) -> Void in
            
        })

        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
    }

}

extension FirstViewController: NHNavigationBarDelegate {
    func backButtonClicked() {
        // filter button clicked
        if let filterText = self.searchField.text, !filterText.isEmpty {
            let filterList = NHDBManager.shared.getEmployees(filterByName: filterText)
            let stiryboardMain = UIStoryboard(name: "Main", bundle: nil)
            let vc1 = stiryboardMain.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
            vc1.employeeList = filterList
            self.navigationController?.pushViewController(vc1, animated: true)
        }
    }
    
    func rightButtonClicked() {
        // add button clicked
        self.showAlertViewForAddEmployee()
    }
    
}

extension FirstViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.employeeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TempViewCell.reuseIdentifier()) as? TempViewCell else {
            fatalError("The dequeued cell is not an instance of TempViewCell.")
        }
        let singleEmployee = self.employeeList[indexPath.row]
        cell.tvDelegate = self
        cell.index = indexPath.row
        cell.nameLabel.text = "Name: " + (singleEmployee.employee_name ?? "")
        cell.salaryLabel.text = "Salary: " + String(singleEmployee.employee_salary)
        cell.ageLabel.text = "Age: " + String(singleEmployee.employee_age)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let navController = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
        for vc in navController.viewControllers {
            if vc is NHTabBarController {
                let singleEmployee = self.employeeList[indexPath.row]
                let tabVC = vc as! NHTabBarController
                tabVC.gotoSecondPage(_dbSindleEmployee: singleEmployee)
            }
            print("nirob test vc is \(vc)")
        }
    }
    
    
}

extension FirstViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension FirstViewController: TempViewCellDelegate {
    func editButtonClicked(atIndex: Int) {
        let singleEmployee = self.employeeList[atIndex]
        
        self.showAlertViewForEditName(_singleEmployee: singleEmployee)
    }
}
