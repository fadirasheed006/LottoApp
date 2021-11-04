//
//  User.swift
//  mentionedUser
//
//  Created by Fahad on 04/11/2021.
//

import UIKit
import Hakawai
class User: NSObject {
    var id:String!
    var name:String!
    
    init(id:String,name:String){
        self.id = id
        self.name = name
    }
}

extension  User:HKWMentionsEntityProtocol{
    
    func entityId() -> String! {
        return id
    }
    
    func entityName() -> String! {
        return name
    }
    
    func entityMetadata() -> [AnyHashable : Any]! {
        return [self.id:self.name]
    }
    
    
}
