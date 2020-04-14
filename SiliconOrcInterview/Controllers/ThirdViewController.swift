//
//  ThirdViewController.swift
//  SiliconOrcInterview
//
//  Created by Nirob Hasan on 14/4/20.
//  Copyright © 2020 Nirob Hasan. All rights reserved.
//

import UIKit

class ThirdViewController: BaseViewController {
    @IBOutlet weak var nhNavigationBar: NHNavigationBar!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    
    @IBOutlet weak var firstTableView: UITableView!
    @IBOutlet weak var secondTableView: UITableView!
    @IBOutlet weak var thirdTableView: UITableView!
    
    private var firstEmployeeList: [DBSingleEmployee] = [DBSingleEmployee]()
    private var secondEmployeeList: [DBSingleEmployee] = [DBSingleEmployee]()
    private var thirdEmployeeList: [DBSingleEmployee] = [DBSingleEmployee]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let nib = UINib(nibName: SortedBySalaryCell.nibName(), bundle: nil)
        firstTableView.register(nib, forCellReuseIdentifier: SortedBySalaryCell.reuseIdentifier())
        
        let nib2 = UINib(nibName: SortedBySalaryCell.nibName(), bundle: nil)
        secondTableView.register(nib2, forCellReuseIdentifier: SortedBySalaryCell.reuseIdentifier())
        
        let nib3 = UINib(nibName: SortedBySalaryCell.nibName(), bundle: nil)
        thirdTableView.register(nib3, forCellReuseIdentifier: SortedBySalaryCell.reuseIdentifier())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.callDBData()
    }
    
    func setupNavBar() {
        nhNavigationBar.setTitleLabel(title: "Collection View")
        //nhNavigationBar.setBackButton()
    }
    
    func callDBData() {
        let allEmployeeList = NHDBManager.shared.getEmployees().sorted(by: {$0.employee_salary < $1.employee_salary})
        self.firstEmployeeList = allEmployeeList.filter({$0.employee_salary > 300000})
        self.secondEmployeeList = allEmployeeList.filter({($0.employee_salary < 300000) && ($0.employee_salary > 100000)})
        self.thirdEmployeeList = allEmployeeList.filter({$0.employee_salary < 100000})
        
        self.firstTableView.reloadData()
        self.secondTableView.reloadData()
        self.thirdTableView.reloadData()
    }
    
    func showAlertViewForTotalAmount(_total: Int) {
        let alertController = UIAlertController(title: "Total Salary", message: "Total Salary: \(_total)", preferredStyle: UIAlertController.Style.alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {
            (action : UIAlertAction!) -> Void in
            
        })

        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
    }

}

extension ThirdViewController: NHNavigationBarDelegate {
    func backButtonClicked() {
        
    }
    
    func rightButtonClicked() {
        
    }
    
}

extension ThirdViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == firstTableView {
            return firstEmployeeList.count
        }
        else if tableView == secondTableView {
            return secondEmployeeList.count
        }
        else if tableView == thirdTableView {
            return thirdEmployeeList.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SortedBySalaryCell.reuseIdentifier()) as? SortedBySalaryCell else {
            fatalError("The dequeued cell is not an instance of SortedBySalaryCell.")
        }
        var singleEmployee = DBSingleEmployee()
        
        if tableView == firstTableView {
            singleEmployee = self.firstEmployeeList[indexPath.row]
        }
        else if tableView == secondTableView {
            singleEmployee = self.secondEmployeeList[indexPath.row]
        }
        else if tableView == thirdTableView {
            singleEmployee = self.thirdEmployeeList[indexPath.row]
        }
        
        cell.selectionStyle = .none
        cell.nameLabel.text = "Name: " + (singleEmployee.employee_name ?? "")
        cell.salaryLabel.text = "Salary: " + String(singleEmployee.employee_salary)
        cell.ageLabel.text = "Age: " + String(singleEmployee.employee_age)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var totalAmount = 0
        if tableView == firstTableView {
            totalAmount = self.firstEmployeeList.reduce(0){$0 + $1.employee_salary}
            print("nirob test totalamount \(totalAmount)")
        }
        else if tableView == secondTableView {
            totalAmount = self.secondEmployeeList.reduce(0){$0 + $1.employee_salary}
            print("nirob test totalamount \(totalAmount)")
        }
        else if tableView == thirdTableView {
            totalAmount = self.thirdEmployeeList.reduce(0){$0 + $1.employee_salary}
            print("nirob test totalamount \(totalAmount)")
        }
        
        self.showAlertViewForTotalAmount(_total: totalAmount)
    }
    
    
}

extension ThirdViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
