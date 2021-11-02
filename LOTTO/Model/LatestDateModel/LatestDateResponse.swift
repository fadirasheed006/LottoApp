//
//	RootClass.swift
//
//	Create by Fahad on 2/11/2021
//	Copyright © 2021. All rights reserved.
//	

import Foundation 
import ObjectMapper


public class LatestDateResponse : NSObject, NSCoding, Mappable{

	var code : String?
	var drawdate : String?
	var result : [LatestDateResultList]?


	class func newInstance(map: Map) -> Mappable?{
		return LatestDateResponse()
	}
    required public init?(map: Map){}
	 override init(){}

    public func mapping(map: Map)
	{
		code <- map["code"]
		drawdate <- map["drawdate"]
		result <- map["result"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required public init(coder aDecoder: NSCoder)
	{
         code = aDecoder.decodeObject(forKey: "code") as? String
         drawdate = aDecoder.decodeObject(forKey: "drawdate") as? String
         result = aDecoder.decodeObject(forKey: "result") as? [LatestDateResultList]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc public func encode(with aCoder: NSCoder)
	{
		if code != nil{
			aCoder.encode(code, forKey: "code")
		}
		if drawdate != nil{
			aCoder.encode(drawdate, forKey: "drawdate")
		}
		if result != nil{
			aCoder.encode(result, forKey: "result")
		}

	}

}
