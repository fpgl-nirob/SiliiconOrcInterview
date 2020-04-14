//
//  APIBase.swift
//  Template
//
//  Created by mac pro-t1 on 2/2/20.
//  Copyright © 2020 mac pro-t1. All rights reserved.
//

import Foundation
import Alamofire

class APIBase {
    class func callAPIRequestWithEncoding(requestURL: String,
                                          method: HTTPMethod,
                                          params: Parameters?,
                                          header: HTTPHeaders?,
                                          completionHandler: @escaping(NSDictionary?, NSError?) -> ()) {
        NHLog("request-url: \(requestURL)\n\(String(describing: params)) method: \(method)\n header: \(String(describing: header))")
        Alamofire.request(requestURL, method: method, parameters: params, encoding: URLEncoding.default, headers: header).responseJSON { (response) in
            if let result = response.result.value as? NSDictionary {
                completionHandler(result, nil)
            } else {
                completionHandler(nil, response.result.error as NSError?)
            }
        }
    }
    
    class func callImageUploadAPIRequest(requestURL: String,
                              method: HTTPMethod,
                              params: Parameters?,
                              imageParams: [String: UIImage]? = nil,
                              header: HTTPHeaders?,
                              completionHandler: @escaping(NSDictionary?, NSError?) -> ()) {
        
        NHLog("request-url: \(requestURL)\n\(String(describing: params))method: \(method)\n\(String(describing: header))")
        
        // Call API
        Alamofire.upload(multipartFormData: { (multipartFormData: MultipartFormData) in
            // Images
            if imageParams != nil {
                for imageParamChild in imageParams! {
                    if let imageData = imageParamChild.value.jpegData(compressionQuality: 1.0) {
                        //                    if let imageData: Data = UIImagePNGRepresentation(imageParamChild.value) {
                        multipartFormData.append(imageData,
                                                 withName: imageParamChild.key,
                                                 fileName: "file.jpg",
                                                 mimeType: "image/jpeg")
                    }
                }
            }
            
            // Texts
            if params != nil {
                for paramChild in params! {
                    let valueStringData: String? = String(describing: paramChild.value)
                    if let valueData: Data = valueStringData?.data(using: String.Encoding.utf8) {
                        multipartFormData.append(valueData, withName: paramChild.key)
                    }
                }
            }
        },to: requestURL,
          method: method,
          headers: header) { (result: SessionManager.MultipartFormDataEncodingResult) in
            switch result {
            case .failure(let encodingError):
                print(encodingError.localizedDescription)
                break
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress: Progress) in
                }).responseJSON(completionHandler: { (response) in
                    switch response.result {
                        
                    case .success(let JSON):
                        let responseDictionary = JSON as? NSDictionary
                        if let _responseDictionary = responseDictionary {
                            NHLog("response-data: \(_responseDictionary)")
                            completionHandler(_responseDictionary, nil)
                        }
                        
                    case .failure(let error):
                        completionHandler(nil, error as NSError)
                    }
                })
                break
            }
        }
    }
}
