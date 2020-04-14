//
//  APIBase.swift
//  Template
//
//  Created by mac pro-t1 on 1/30/20.
//  Copyright © 2020 mac pro-t1. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NHAPIServices {
    class func callAPIForTest(completionHandler: @escaping (NSArray?, Error?) -> ()) {
        let requestUrl = NHConstants.APIConstants.BASE_URL + NHConstants.APIConstants.USER_LIST
        APIBase.callAPIRequestWithEncoding(requestURL: requestUrl, method: .get, params: nil, header: nil, completionHandler: {(result, error) in
            if let _result = result?["data"] as? NSArray {
                //let jsonData = JSON(_result[0])
                //let apiSingleEmployee = APISingleEmployee.getDBSingleEmployeeFromJSON(jsonData: jsonData)
                //NHLog("result: \(apiSingleEmployee.employeeId) \(String(describing: apiSingleEmployee.employee_name))")
                completionHandler(_result, nil)
            }
            else {
                NHLog("error: \(String(describing: error))")
                completionHandler(nil, error)
            }
        })
    }
}
