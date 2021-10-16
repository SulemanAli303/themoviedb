//
//  CDManager.swift
//  Test project themoviedb
//
//  Created by Suleman on 14/10/2021.
//


import Foundation
import CoreData
import SwiftyJSON
import UIKit


class CDManager: NSObject {
    
   
    
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    class var context : NSManagedObjectContext {
        return getContext()
    }
    
}
