//
//	RootClass.swift
//
//	Create by Fahad on 2/11/2021
//	Copyright © 2021. All rights reserved.
//	

import Foundation 
import ObjectMapper


public class VerifyResponse : NSObject, NSCoding, Mappable{

	var code : String?
	var result : [VerifyResult]?
	var winner : Bool?


	class func newInstance(map: Map) -> Mappable?{
		return VerifyResponse()
	}
    required public init?(map: Map){}
	private override init(){}

    public func mapping(map: Map)
	{
		code <- map["code"]
		result <- map["result"]
		winner <- map["winner"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required public init(coder aDecoder: NSCoder)
	{
         code = aDecoder.decodeObject(forKey: "code") as? String
         result = aDecoder.decodeObject(forKey: "result") as? [VerifyResult]
         winner = aDecoder.decodeObject(forKey: "winner") as? Bool

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
		if winner != nil{
			aCoder.encode(winner, forKey: "winner")
		}

	}

}
