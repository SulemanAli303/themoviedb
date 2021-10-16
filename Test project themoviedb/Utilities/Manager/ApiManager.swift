//
//  ApiManager.swift
//  Test project themoviedb
//
//  Created by Suleman on 14/10/2021.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

enum VoidResult {
    case success(result:JSON)
    case failure(NSError)
}



struct ResponseCode{
    
    static var loginAgain = 404
    static var success = 200
    static var permissionDenied = 401
    
}



class ApiManager: NSObject {
    
    class func headers() -> HTTPHeaders {
        var headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        //        if let authToken = UserDefaults.standard.string(forKey: "token") {
        //            headers["Authorization"] = "Bearer " + authToken
        //        }
        
        return headers
    }
    
    class func postRequest(with url: String,parameters: [String:Any], completion: @escaping (_ result: VoidResult) -> ())
    {
        
        if Reachability.isConnectedToNetwork(){
            print("url: ",url)
            print("param: ",JSON(parameters))
            Functions.showActivity()
            AF.request(url,method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted, headers: ApiManager.headers()).responseJSON { (response:AFDataResponse<Any>) in
                Functions.hideActivity()
                if let jsonObject = response.value
                {
                    let json = JSON(jsonObject)
                    print(json)
                    if response.response?.statusCode == ResponseCode.success{
                        completion(.success(result: json))
                    }
                    
                    else{
                        completion(.failure(NSError(domain: json["status_message"].stringValue, code: json["status_code"].intValue, userInfo: [NSLocalizedDescriptionKey:json["status_message"].stringValue])))
                    }
                } else if let error = response.error {
                    
                    completion(.failure(error as NSError))
                    
                    
                }else {
                    Functions.showToast(message: "System Error", duration: 3.0, position: .center)
                    
                }
            }
        }else{
            Functions.noInternetConnection(status: true)
        }
        print(url)
        
        
    }
    
    
    
    class func getRequest(with url: String,parameters: [String:Any]?, completion: @escaping (_ result: VoidResult) -> ())
    {
        print("url: ",url)
        print("param: ",JSON(parameters ?? [:]))
        var finalURL = url
        for  param in parameters ?? [:] {
            finalURL  = finalURL.replacingOccurrences(of: "{\(param.key)}", with: "\(param.value)")
        }
        if Reachability.isConnectedToNetwork(){
            AF.request(finalURL,method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString) , headers:ApiManager.headers()).responseJSON { (response:AFDataResponse<Any>) in
                Functions.hideActivity()
                if let jsonObject = response.value
                {
                    let json = JSON(jsonObject)
                    print(json)
                    if response.response?.statusCode == ResponseCode.success{
                        Functions.saveJSON(json: json, key: finalURL)
                        completion(.success(result: json))
                        
                        
                    }
                    
                    else{
                        completion(.failure(NSError(domain: json["status_message"].stringValue, code: json["status_code"].intValue, userInfo: [NSLocalizedDescriptionKey:json["status_message"].stringValue])))
                    }
                } else if let error = response.error {
                    
                    completion(.failure(error as NSError))
                    
                    
                } else {
                    Functions.showToast(message: "System Error", duration: 3.0, position: .center)
                    
                }
            }
        }else{
            Functions.hideActivity()
            
            if let json  = Functions.getJSON( finalURL) {
                completion(.success(result: json))
            }
            
            Functions.noInternetConnection(status: true)
            
        }
        print(url)
        
    }
    
    
    
    
}





