//
//  Functions.swift
//  Test project themoviedb
//
//  Created by Suleman on 14/10/2021.
//


import Foundation
import UIKit
import SwiftMessages
import Toast_Swift
import SVProgressHUD
import SwiftyJSON




class Functions: NSObject {
    class func saveJSON(json: JSON, key:String){
        if let jsonString = json.rawString() {
            UserDefaults.standard.setValue(jsonString, forKey: key)
        }
    }
    
    class func getJSON(_ key: String)-> JSON? {
        var p = ""
        if let result = UserDefaults.standard.string(forKey: key) {
            p = result
        }
        if p != "" {
            if let json = p.data(using: String.Encoding.utf8, allowLossyConversion: false) {
                do {
                    return try JSON(data: json)
                } catch {
                    return nil
                }
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    static func whereIsMySQLite() {
        let path = FileManager
            .default
            .urls(for: .applicationSupportDirectory, in: .userDomainMask)
            .last?
            .absoluteString
            .replacingOccurrences(of: "file://", with: "")
            .removingPercentEncoding
        
        print(path ?? "Not found")
    }
    
    
    
    static func showToast(message:String,duration:Double = 2.0 ,position:ToastPosition = .bottom){
        let window = UIApplication.shared.keyWindow!
        window.hideAllToasts()
        window.makeToast(message, duration: duration, position: position)
    }
    static func showActivity(progres:Double = 0.0){
        if progres == 0.0{
            SVProgressHUD.show(withStatus: "Loading")
            SVProgressHUD.setDefaultMaskType(.clear)
        }else{
            let value = progres*100
            SVProgressHUD.showProgress(Float(progres), status: String(format: "%.1f percent", value))
            SVProgressHUD.setBackgroundColor(.lightGray)
        }
    }
    
    static func hideActivity(){
        SVProgressHUD.dismiss()
    }
    
    static func noInternetConnection(status:Bool){
        
        if status == true{
            SwiftMessages.hideAll()
            SwiftMessages.pauseBetweenMessages = 0.0
            
            let view: MessageView
            view = try! SwiftMessages.viewFromNib()
            
            view.configureContent(title: "", body: "Please check your internet connection", iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: "", buttonTapHandler: { _ in
                
                SwiftMessages.hide()
                
            })
            view.accessibilityPrefix = "error"
            view.configureDropShadow()
            view.button?.isHidden = true
            
            var config = SwiftMessages.defaultConfig
            config.presentationStyle = .top
            config.presentationContext = .window(windowLevel: .statusBar)
            config.preferredStatusBarStyle = .lightContent
            config.interactiveHide = false
            config.duration = .forever
            view.configureTheme(backgroundColor: UIColor.red, foregroundColor: UIColor.white, iconImage: nil, iconText: nil)
            
            config.dimMode = .gray(interactive: true)
            SwiftMessages.show(config: config, view: view)
            
        }else{
            SwiftMessages.hide()
            SwiftMessages.hideAll()
            SwiftMessages.pauseBetweenMessages = 0.0
        }
        
    }
    
    
    static func ChangeDateFormateReturnString( dateString : String ,formate : String) -> String {
        
        if dateString != ""{
            let strDate = dateString
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            
            let date = dateFormatter.dateFromMultipleFormats(fromString: strDate)
            
            dateFormatter.dateFormat = formate
            
            let myStringafd = dateFormatter.string(from: date ?? Date())
            
            return myStringafd
        }else{
            return ""
        }
        
    }
}


extension DateFormatter {
    /// return Date from String ny different Format
    func dateFromMultipleFormats(fromString dateString: String) -> Date? {
         let formats: [String] = [
            "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSSS",
            "yyyy-MM-dd'T'HH:mm:ss",
            "yyyy-MM-dd'T'HH:mm:ss +zzzz",
            "yyyy-MM-dd'T'HH:mm:ss.SSSS +zzzz",
            "yyyy-MM-dd'T'HH:mm:ss.SSSS'Z'",
            "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ",
            "yyyy-MM-ddTHH:mm:ssZ",
            "yyyy-MM-dd'T'hh:mm:ssZ",
            "yyyy-MM-ddTHH:mm:ss",
            "yyyy-MM-dd'T'HH:mm:ss.SSSS+XXX",
            "yyyy-MM-dd'T'HH:mm:ss.SSSSSSS+XXX",
            "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSXXX",
            "yyyy-MM-dd'T'HH:mm:ss.SSSSXXX",
            "yyyy-MM-dd'T'HH:mm:ss.SSS",
            "yyyy-MM-dd'T'hh:mm:ss.SSS",
            "yyyy-MM-dd'T'HH:mm:ss.SSSS",
            "yyyy-MM-dd'T'hh:mm:ss.SSSS",
            "yyyy-MM-dd'T'HH:mm:ss.SSSS a",
            "yyyy-MM-dd'T'hh:mm:ss.SSSS a",
            "yyyy-MM-dd'T'hh:mm:ss",
            "yyyy-MM-dd'T'HH:mm:ss",
            "yyyy-MM-dd'T'HH:mm:ss +zzzz",
            "yyyy-MM-dd'T'hh:mm:ss +zzzz",
            "yyyy-MM-dd'T'HH:mm:ss.SSSS +zzzz",
            "yyyy-MM-dd'T'hh:mm:ss.SSSS +zzzz",
            "yyyy-MM-dd'T'HH:mm:ss.SSSS'Z'",
            "yyyy-MM-dd'T'hh:mm:ss.SSSS'Z'",
            "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'",
            "yyyy-MM-dd'T'hh:mm:SSZ",
            "dd-MMM-yy HH:mm"
            
        ]
        for format in formats {
            self.dateFormat = format
            if let date = self.date(from: dateString) {
                return date
            }
        }
        
        return nil
    }
}
