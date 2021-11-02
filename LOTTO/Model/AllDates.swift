//
//	Result.swift
//
//	Create by Fahad on 2/11/2021
//	Copyright © 2021. All rights reserved.
//	

import Foundation 
import ObjectMapper


class AllDates : NSObject, NSCoding, Mappable{

	var lottoNameSpace : String?
	var thaidate : String?


	class func newInstance(map: Map) -> Mappable?{
		return AllDates()
	}
	required init?(map: Map){}
	 override init(){}

	func mapping(map: Map)
	{
		lottoNameSpace <- map["lotto_name_space"]
		thaidate <- map["thaidate"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         lottoNameSpace = aDecoder.decodeObject(forKey: "lotto_name_space") as? String
         thaidate = aDecoder.decodeObject(forKey: "thaidate") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if lottoNameSpace != nil{
			aCoder.encode(lottoNameSpace, forKey: "lotto_name_space")
		}
		if thaidate != nil{
			aCoder.encode(thaidate, forKey: "thaidate")
		}

	}

}
