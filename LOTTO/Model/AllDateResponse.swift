//
//	RootClass.swift
//
//	Create by Fahad on 2/11/2021
//	Copyright © 2021. All rights reserved.
//	

import Foundation 
import ObjectMapper


public class AllDateResponse : NSObject, NSCoding, Mappable{

	var code : String?
	var result : [AllDates]?


	class func newInstance(map: Map) -> Mappable?{
		return AllDateResponse()
	}
    required public init?(map: Map){}
	 override init(){}

    public func mapping(map: Map)
	{
		code <- map["code"]
		result <- map["result"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required public init(coder aDecoder: NSCoder)
	{
         code = aDecoder.decodeObject(forKey: "code") as? String
         result = aDecoder.decodeObject(forKey: "result") as? [AllDates]

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
		if result != nil{
			aCoder.encode(result, forKey: "result")
		}

	}

}
