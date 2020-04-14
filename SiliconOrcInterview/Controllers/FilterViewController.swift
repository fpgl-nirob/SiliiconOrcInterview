//
//  FilterViewController.swift
//  SiliconOrcInterview
//
//  Created by Nirob Hasan on 14/4/20.
//  Copyright © 2020 Nirob Hasan. All rights reserved.
//

import UIKit

class FilterViewController: BaseViewController {
    @IBOutlet weak var nhNavigationBar: NHNavigationBar!
    @IBOutlet weak var customerTableView: UITableView!
    
    public var employeeList: [DBSingleEmployee] = [DBSingleEmployee]()

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
        
    }
    
    func setupNavBar() {
        nhNavigationBar.setTitleLabel(title: "Employee List")
        nhNavigationBar.setBackButton()
    }

}

extension FilterViewController: NHNavigationBarDelegate {
    func backButtonClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension FilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.employeeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TempViewCell.reuseIdentifier()) as? TempViewCell else {
            fatalError("The dequeued cell is not an instance of TempViewCell.")
        }
        let singleEmployee = self.employeeList[indexPath.row]
        cell.index = indexPath.row
        cell.nameLabel.text = "Name: " + (singleEmployee.employee_name ?? "")
        cell.salaryLabel.text = "Salary: " + String(singleEmployee.employee_salary)
        cell.ageLabel.text = "Age: " + String(singleEmployee.employee_age)
        
        
        return cell
    }
    
    
}

extension FilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
