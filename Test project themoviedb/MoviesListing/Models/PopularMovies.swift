//
//  PopularMovies.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 14, 2021

import Foundation
import SwiftyJSON


class PopularMovies : NSObject, NSCoding{

    var page : Int!
    var results : [Movie]!
 
    var totalPages : Int!
    var totalResults : Int!

	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
        page = json["page"].intValue
        results = [Movie]()
        
        for resultsJson in json["results"].arrayValue{
            let item =  Movie(fromJson: resultsJson)
           
            results.append(item)
        }
        totalPages = json["total_pages"].intValue
        totalResults = json["total_results"].intValue
	}
    override init() {
        page = 0
        results = []
        
        totalPages = 0
        totalResults = 0
    }
	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
        if page != nil{
        	dictionary["page"] = page
        }
        if results != nil{
        var dictionaryElements = [[String:Any]]()
        for resultsElement in results {
        	dictionaryElements.append(resultsElement.toDictionary())
        }
        dictionary["results"] = dictionaryElements
        }
        if totalPages != nil{
        	dictionary["total_pages"] = totalPages
        }
        if totalResults != nil{
        	dictionary["total_results"] = totalResults
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
		page = aDecoder.decodeObject(forKey: "page") as? Int
		results = aDecoder.decodeObject(forKey: "results") as? [Movie]
		totalPages = aDecoder.decodeObject(forKey: "total_pages") as? Int
		totalResults = aDecoder.decodeObject(forKey: "total_results") as? Int
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if page != nil{
			aCoder.encode(page, forKey: "page")
		}
		if results != nil{
			aCoder.encode(results, forKey: "results")
		}
		if totalPages != nil{
			aCoder.encode(totalPages, forKey: "total_pages")
		}
		if totalResults != nil{
			aCoder.encode(totalResults, forKey: "total_results")
		}

	}

}
