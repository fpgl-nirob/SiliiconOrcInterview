//
//  DBQuran.swift
//  quran-ios
//
//  Created by Nirob Hasan on 31/5/19.
//  Copyright © 2019 mac pro-t1. All rights reserved.
//

import UIKit
import SQLite

final class NHDBManager: NSObject {
    static let shared = NHDBManager()
    private var database: Connection!
    
    //MARK: Employee Table
    private var employeeTable: Table = Table("employees")
    let etEmployeeId = Expression<Int>("id")
    let etEmployeeName = Expression<String>("employee_name")
    let etEmployeeSalary = Expression<Int>("employee_salary")
    let etEmployeeAge = Expression<Int>("employee_age")
    let etProfileImage = Expression<String>("profile_image")
    
    private override init() {
        
    }
    
    private func getDocumentDatabasePath() -> String {
        let documentsURL = URL(fileURLWithPath: NHConstants.Path.DOCUMENTS_DIRECTORY)
        let destURL = documentsURL.appendingPathComponent(NHConstants.Database.FileName).appendingPathExtension(NHConstants.Database.FileExt)
        return destURL.path
    }
    
    private func getBundleDatabasePath() -> String {
        guard let sourceURL = Bundle.main.url(forResource: NHConstants.Database.FileName, withExtension: NHConstants.Database.FileExt)
            else {
                fatalError("\(NHConstants.Database.FileName).\(NHConstants.Database.FileExt) File not found")
        }
        return sourceURL.path
    }
    
    public func initializeDB() { 
        self.copyDatabaseInDocumentIfNotExist()
        do {
            database = try Connection(self.getDocumentDatabasePath())
            print("database initialization success")
        } catch {
            print("database initialization error: \(error)")
        }
    }
    
    func getEmployees() -> [DBSingleEmployee] {
        var employees: [DBSingleEmployee] = [DBSingleEmployee]()
        if database == nil {
            print("database is not initialized")
            return employees
        }
        do {
            print("database query prepare success")
            for row in try database.prepare(employeeTable) {
                let dbEmploye = DBSingleEmployee.getDataFromRow(rowData: row)
                employees.append(dbEmploye)
            }
        } catch {
            print("database query prepare error: \(error)")
        }
        return employees
    }
    
    func getEmployees(filterByName: String) -> [DBSingleEmployee] {
        var employees: [DBSingleEmployee] = [DBSingleEmployee]()
        if database == nil {
            print("database is not initialized")
            return employees
        }
        do {
            print("database query prepare success")
            for row in try database.prepare(employeeTable) {
                let dbEmploye = DBSingleEmployee.getDataFromRow(rowData: row)
                if dbEmploye.employee_name?.lowercased().contains(filterByName.lowercased()) ?? false {
                    employees.append(dbEmploye)
                }
            }
        } catch {
            print("database query prepare error: \(error)")
        }
        return employees
    }
    
    func getEmployee(_employeeId: Int) -> DBSingleEmployee {
        var dbEmploye: DBSingleEmployee = DBSingleEmployee()
        if database == nil {
            print("database is not initialized")
            return dbEmploye
        }
        do {
            print("database query prepare success")
            for row in try database.prepare(employeeTable.where(self.etEmployeeId == _employeeId)) {
                dbEmploye = DBSingleEmployee.getDataFromRow(rowData: row)
                break
            }
        } catch {
            print("database query prepare error: \(error)")
        }
        return dbEmploye
    }
    
    func insertIntoEmploye(_apiSingleEmployee: APISingleEmployee) -> Bool {
        
        if database == nil {
            print("database is not initialized")
            return false
        }
        do {
            print("database query prepare success")
            let insert = self.employeeTable.insert(self.etEmployeeId <- _apiSingleEmployee.employeeId, self.etEmployeeName <- _apiSingleEmployee.employee_name ?? "", self.etEmployeeSalary <- _apiSingleEmployee.employee_salary, self.etEmployeeAge <- _apiSingleEmployee.employee_age, self.etProfileImage <- _apiSingleEmployee.profile_image ?? "")
            try database.run(insert)
            return true
        } catch {
            print("database query prepare error: \(error)")
        }
        return false
    }
    
    func updateEmployee(_apiSingleEmployee: APISingleEmployee) -> Bool {
        
        if database == nil {
            print("database is not initialized")
            return false
        }
        do {
            print("database query prepare success")
            let alice = self.employeeTable.filter(_apiSingleEmployee.employeeId == etEmployeeId)
            try database.run(alice.update(etEmployeeName <- _apiSingleEmployee.employee_name ?? "", etEmployeeSalary <- _apiSingleEmployee.employee_salary, etEmployeeAge <- _apiSingleEmployee.employee_age, etProfileImage <- _apiSingleEmployee.profile_image ?? ""))
            return true
        } catch {
            print("database query prepare error: \(error)")
        }
        
        return false
    }
    
    func updateEmployeeName(_employeeId: Int, _name: String) -> Bool {
        
        if database == nil {
            print("database is not initialized")
            return false
        }
        do {
            print("database query prepare success")
            let alice = self.employeeTable.filter(_employeeId == etEmployeeId)
            try database.run(alice.update(etEmployeeName <- _name))
            return true
        } catch {
            print("database query prepare error: \(error)")
        }
        
        return false
    }
    
    private func copyDatabaseInDocumentIfNotExist() {
        let destURL = URL(fileURLWithPath: self.getDocumentDatabasePath())
        guard let sourceURL = Bundle.main.url(forResource: NHConstants.Database.FileName, withExtension: NHConstants.Database.FileExt)
            else {
                print("Source File not found.")
                return
        }
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: destURL.path) {
            do {
                try fileManager.copyItem(at: sourceURL, to: destURL)
            } catch {
                print("Unable to copy file error: \(error)")
            }
        }
    }
}
