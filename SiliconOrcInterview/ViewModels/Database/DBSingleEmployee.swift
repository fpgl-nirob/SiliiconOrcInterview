//
//  DBSuraNames.swift
//  quran-ios
//
//  Created by Nirob Hasan on 23/10/19.
//  Copyright © 2019 mac pro-t1. All rights reserved.
//

import Foundation
import SQLite

class DBSingleEmployee: NSObject, NSCopying {
    var employeeId: Int
    var employee_name: String?
    var employee_salary: Int
    var employee_age: Int
    var profile_image: String?
    
    public override init() {
        self.employeeId = 0
        self.employee_name = nil
        self.employee_salary = 0
        self.employee_age = 0
        self.profile_image = nil
    }
    
    required init(_ dbSingleEmployee: DBSingleEmployee) {
        self.employeeId = dbSingleEmployee.employeeId
        self.employee_name = dbSingleEmployee.employee_name
        self.employee_salary = dbSingleEmployee.employee_salary
        self.employee_age = dbSingleEmployee.employee_age
        self.profile_image = dbSingleEmployee.profile_image
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return type(of:self).init(self)
    }
    
    public class func getDataFromRow(rowData: Row) -> DBSingleEmployee {
        let dbSingleEmployee = DBSingleEmployee()
        dbSingleEmployee.employeeId = rowData[NHDBManager.shared.etEmployeeId]
        dbSingleEmployee.employee_name = rowData[NHDBManager.shared.etEmployeeName]
        dbSingleEmployee.employee_salary = rowData[NHDBManager.shared.etEmployeeSalary]
        dbSingleEmployee.employee_age = rowData[NHDBManager.shared.etEmployeeAge]
        dbSingleEmployee.profile_image = rowData[NHDBManager.shared.etProfileImage]
        
        return dbSingleEmployee
    }
    
    func convertToAPISingleEmployee() -> APISingleEmployee {
        let apiSingleEmployee = APISingleEmployee()
        apiSingleEmployee.employeeId = self.employeeId
        apiSingleEmployee.employee_name = self.employee_name
        apiSingleEmployee.employee_salary = self.employee_salary
        apiSingleEmployee.employee_age = self.employee_age
        apiSingleEmployee.profile_image = self.profile_image
        
        return apiSingleEmployee
    }
}
