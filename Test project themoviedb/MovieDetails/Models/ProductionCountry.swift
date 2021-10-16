//
//  ProductionCountry.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 14, 2021

import Foundation
import SwiftyJSON

/// Production Country of Movie
class ProductionCountry : NSObject, NSCoding{

    var iso31661 : String!
    var name : String!

	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
        iso31661 = json["iso_3166_1"].stringValue
        name = json["name"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
        if iso31661 != nil{
        	dictionary["iso_3166_1"] = iso31661
        }
        if name != nil{
        	dictionary["name"] = name
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
		iso31661 = aDecoder.decodeObject(forKey: "iso_3166_1") as? String
		name = aDecoder.decodeObject(forKey: "name") as? String
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if iso31661 != nil{
			aCoder.encode(iso31661, forKey: "iso_3166_1")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}

	}

}
