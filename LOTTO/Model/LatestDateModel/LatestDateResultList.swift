//
//	Result.swift
//
//	Create by Fahad on 2/11/2021
//	Copyright © 2021. All rights reserved.
//	

import Foundation 
import ObjectMapper


class LatestDateResultList : NSObject, NSCoding, Mappable{

	var amount : Int?
	var id : String?
	var name : String?
	var number : Any?
	var reward : Int?


	class func newInstance(map: Map) -> Mappable?{
		return LatestDateResultList()
	}
	required init?(map: Map){}
	 override init(){}

	func mapping(map: Map)
	{
		amount <- map["amount"]
		id <- map["id"]
		name <- map["name"]
		number <- map["number"]
		reward <- map["reward"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         amount = aDecoder.decodeObject(forKey: "amount") as? Int
         id = aDecoder.decodeObject(forKey: "id") as? String
         name = aDecoder.decodeObject(forKey: "name") as? String
         number = aDecoder.decodeObject(forKey: "number") as? Any
         reward = aDecoder.decodeObject(forKey: "reward") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if amount != nil{
			aCoder.encode(amount, forKey: "amount")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if number != nil{
			aCoder.encode(number, forKey: "number")
		}
		if reward != nil{
			aCoder.encode(reward, forKey: "reward")
		}

	}

}
