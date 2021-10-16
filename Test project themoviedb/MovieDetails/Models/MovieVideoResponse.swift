//
//  MovieVideoResponse.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 14, 2021

import Foundation
import SwiftyJSON

/// model for Movies Video  Response 
class MovieVideoResponse : NSObject, NSCoding{

    var id : Int!
    var trailers : [Trailer]!

	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
        id = json["id"].intValue
        trailers = [Trailer]()
     
        for resultsJson in json["results"].arrayValue{
            let value = Trailer(fromJson: resultsJson)
            trailers.append(value)
        }
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
        if trailers != nil{
        var dictionaryElements = [[String:Any]]()
        for resultsElement in trailers {
        	dictionaryElements.append(resultsElement.toDictionary())
        }
        dictionary["results"] = dictionaryElements
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
        trailers = aDecoder.decodeObject(forKey: "results") as? [Trailer]
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
		if trailers != nil{
			aCoder.encode(trailers, forKey: "results")
		}

	}

}
