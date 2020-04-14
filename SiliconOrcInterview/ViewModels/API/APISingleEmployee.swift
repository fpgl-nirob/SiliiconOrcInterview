//
//  APISingleEmployee.swift
//  Template
//
//  Created by mac pro-t1 on 2/2/20.
//  Copyright © 2020 mac pro-t1. All rights reserved.
//

import Foundation
import SwiftyJSON

class APISingleEmployee: NSObject, NSCopying {
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
    
    required init(_ dbSingleEmployee: APISingleEmployee) {
        self.employeeId = dbSingleEmployee.employeeId
        self.employee_name = dbSingleEmployee.employee_name
        self.employee_salary = dbSingleEmployee.employee_salary
        self.employee_age = dbSingleEmployee.employee_age
        self.profile_image = dbSingleEmployee.profile_image
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return type(of:self).init(self)
    }
    
    public func jsonSerializer() -> [String:Any] {
        
        let jsonData:[String: Any] = [
            "id": self.employeeId,
            "employee_name": self.employee_name as Any,
            "employee_salary": self.employee_salary,
            "employee_age": self.employee_age,
            "profile_image": self.profile_image as Any
        ]
        
        return jsonData
    }
    
    class func getDBSingleEmployeeFromJSON(jsonData: JSON) -> APISingleEmployee {
        
        let apiSingleEmployee = APISingleEmployee()
        apiSingleEmployee.employeeId = jsonData["id"].intValue
        apiSingleEmployee.employee_name = jsonData["employee_name"].string
        apiSingleEmployee.employee_salary = jsonData["employee_salary"].intValue
        apiSingleEmployee.employee_age = jsonData["employee_age"].intValue
        apiSingleEmployee.profile_image = jsonData["profile_image"].string
        
        return apiSingleEmployee
    }
    
    func convertToDBSingleEmployee() -> DBSingleEmployee {
        let dbSingleEmployee = DBSingleEmployee()
        dbSingleEmployee.employeeId = self.employeeId
        dbSingleEmployee.employee_name = self.employee_name
        dbSingleEmployee.employee_salary = self.employee_salary
        dbSingleEmployee.employee_age = self.employee_age
        dbSingleEmployee.profile_image = self.profile_image
        
        return dbSingleEmployee
    }
}
