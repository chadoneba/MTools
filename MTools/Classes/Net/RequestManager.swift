//
//  RequestManager.swift
//  FSMobile
//
//  Created by Aziz Said-Malik on 28.04.17.
//  Copyright © 2017 Aziz Said-Malik. All rights reserved.
//

import Foundation
import UIKit

enum MethodType:String {
    case POST,GET
}

class RequestManager {
    var request:URLRequest
    var type:MethodType {
        get {
            return  MethodType.init(rawValue:request.httpMethod!)!
        }
        set {
            request.httpMethod = newValue.rawValue
        }
    }
    var headers:[String:String]? {
        get {
            return [:]
        }
        set(values) {
            if values != nil {
                for (key,val) in values! {
                    self.request.addValue(val, forHTTPHeaderField: key)
                }
            }
        }
    }
    
    init(host:String) {
        self.request = URLRequest(url: URL(string:host)!)
        self.type = .POST
    }

    func getJsonRequest(params:[String:Any]) {
        print("Json")
        do {
            self.request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }

//        print(String(data: self.request.httpBody!, encoding: .utf8)!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
    }
    
    func getImageRequest(params:[String:String],image:UIImage) {

        var components = URLComponents(url: self.request.url!, resolvingAgainstBaseURL: false)

        components!.queryItems = params.map { (key,val) -> URLQueryItem in
            return URLQueryItem(name: key, value: val)
          }

        self.request = URLRequest(url: components!.url!)
        self.type = .POST

        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
//        request.setValue("application/json; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//          request.setValue("charset=utf-8; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = self.createBody(
            parameters:params
          , boundary: boundary
          , data: UIImageJPEGRepresentation(image, 0.7)!
          , mimeType: "image/jpeg"
          , filename: "file"
        )
    }
    
    func getSimpleRequest(params:[String:String]) {
        let data = params.map { key,val in
            return key+"="+val
            } .joined(separator: "&")
        request.httpBody = data.data(using: String.Encoding.utf8)
    }
    
    func getRequestFrom(str:String) {
        request.httpBody = str.data(using: String.Encoding.utf8)
    }
    
    
    // TODO: код взят с
    // https://newfivefour.com/swift-form-data-multipart-upload-URLRequest.html
    
    // перписаить
    
    func createBody(parameters: [String: String],
                    boundary: String,
                    data: Data,
                    mimeType: String,
                    filename: String) -> Data {
        let body = NSMutableData()
        
        let boundaryPrefix = "--\(boundary)\r\n"
        
//        for (key, value) in parameters {
//            body.appendString(boundaryPrefix)
//            body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
//            body.appendString("\(value)\r\n")
//        }
        
        body.appendString(boundaryPrefix)
        body.appendString("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimeType)\r\n\r\n")
        body.append(data)
        body.appendString("\r\n")
        body.appendString("--".appending(boundary.appending("--")))
        
        return body as Data
    }


    
    // Возвращает объект запроса, превращает словарь параметров в data
    
    
}

extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
    }
    
    
}
