//
//  ProductionCompany.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 14, 2021

import Foundation
import SwiftyJSON

/// model for Movies  Prodction Company 
class ProductionCompany : NSObject, NSCoding{

    var id : Int!
    var logoPath : String!
    var name : String!
    var originCountry : String!

	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
        id = json["id"].intValue
        logoPath = json["logo_path"].stringValue
        name = json["name"].stringValue
        originCountry = json["origin_country"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
        if id != nil{
        	dictionary["id"] = id
        }
        if logoPath != nil{
        	dictionary["logo_path"] = logoPath
        }
        if name != nil{
        	dictionary["name"] = name
        }
        if originCountry != nil{
        	dictionary["origin_country"] = originCountry
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
		id = aDecoder.decodeObject(forKey: "id") as? Int
		logoPath = aDecoder.decodeObject(forKey: "logo_path") as? String
		name = aDecoder.decodeObject(forKey: "name") as? String
		originCountry = aDecoder.decodeObject(forKey: "origin_country") as? String
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if logoPath != nil{
			aCoder.encode(logoPath, forKey: "logo_path")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if originCountry != nil{
			aCoder.encode(originCountry, forKey: "origin_country")
		}

	}

}
